Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from zimbra1.kalray.eu ([92.103.151.219]:33280 "EHLO
        zimbra1.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751491AbeCWHoa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Mar 2018 03:44:30 -0400
Date: Fri, 23 Mar 2018 08:44:27 +0100 (CET)
From: Marta Rybczynska <mrybczyn@kalray.eu>
To: Keith Busch <keith.busch@intel.com>
Cc: Ming Lei <ming.lei@redhat.com>, axboe@fb.com, hch@lst.de,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Pierre-Yves Kerbrat <pkerbrat@kalray.eu>
Message-ID: <1716948335.5924942.1521791067272.JavaMail.zimbra@kalray.eu>
In-Reply-To: <1220434088.5871933.1521648656789.JavaMail.zimbra@kalray.eu>
References: <744877924.5841545.1521630049567.JavaMail.zimbra@kalray.eu> <20180321115037.GA26083@ming.t460p> <464125757.5843583.1521634231341.JavaMail.zimbra@kalray.eu> <20180321154807.GD22254@ming.t460p> <20180321160238.GF12909@localhost.localdomain> <1220434088.5871933.1521648656789.JavaMail.zimbra@kalray.eu>
Subject: Re: [RFC PATCH] nvme: avoid race-conditions when enabling devices
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



----- Mail original -----
> De: "Marta Rybczynska" <mrybczyn@kalray.eu>
> =C3=80: "Keith Busch" <keith.busch@intel.com>
> Cc: "Ming Lei" <ming.lei@redhat.com>, axboe@fb.com, hch@lst.de, sagi@grim=
berg.me, linux-nvme@lists.infradead.org,
> linux-kernel@vger.kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.=
org, "Pierre-Yves Kerbrat"
> <pkerbrat@kalray.eu>
> Envoy=C3=A9: Mercredi 21 Mars 2018 17:10:56
> Objet: Re: [RFC PATCH] nvme: avoid race-conditions when enabling devices

>> On Wed, Mar 21, 2018 at 11:48:09PM +0800, Ming Lei wrote:
>>> On Wed, Mar 21, 2018 at 01:10:31PM +0100, Marta Rybczynska wrote:
>>> > > On Wed, Mar 21, 2018 at 12:00:49PM +0100, Marta Rybczynska wrote:
>>> > >> NVMe driver uses threads for the work at device reset, including e=
nabling
>>> > >> the PCIe device. When multiple NVMe devices are initialized, their=
 reset
>>> > >> works may be scheduled in parallel. Then pci_enable_device_mem can=
 be
>>> > >> called in parallel on multiple cores.
>>> > >>=20
>>> > >> This causes a loop of enabling of all upstream bridges in
>>> > >> pci_enable_bridge(). pci_enable_bridge() causes multiple operation=
s
>>> > >> including __pci_set_master and architecture-specific functions tha=
t
>>> > >> call ones like and pci_enable_resources(). Both __pci_set_master()
>>> > >> and pci_enable_resources() read PCI_COMMAND field in the PCIe spac=
e
>>> > >> and change it. This is done as read/modify/write.
>>> > >>=20
>>> > >> Imagine that the PCIe tree looks like:
>>> > >> A - B - switch -  C - D
>>> > >>                \- E - F
>>> > >>=20
>>> > >> D and F are two NVMe disks and all devices from B are not enabled =
and bus
>>> > >> mastering is not set. If their reset work are scheduled in paralle=
l the two
>>> > >> modifications of PCI_COMMAND may happen in parallel without lockin=
g and the
>>> > >> system may end up with the part of PCIe tree not enabled.
>>> > >=20
>>> > > Then looks serialized reset should be used, and I did see the commi=
t
>>> > > 79c48ccf2fe ("nvme-pci: serialize pci resets") fixes issue of 'fail=
ed
>>> > > to mark controller state' in reset stress test.
>>> > >=20
>>> > > But that commit only covers case of PCI reset from sysfs attribute,=
 and
>>> > > maybe other cases need to be dealt with in similar way too.
>>> > >=20
>>> >=20
>>> > It seems to me that the serialized reset works for multiple resets of=
 the
>>> > same device, doesn't it? Our problem is linked to resets of different=
 devices
>>> > that share the same PCIe tree.
>>>=20
>>> Given reset shouldn't be a frequent action, it might be fine to seriali=
ze all
>>> reset from different devices.
>>=20
>> The driver was much simpler when we had serialized resets in line with
>> probe, but that had a bigger problems with certain init systems when
>> you put enough nvme devices in your server, making them unbootable.
>>=20
>> Would it be okay to serialize just the pci_enable_device across all
>> other tasks messing with the PCI topology?
>>=20
>> ---
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index cef5ce851a92..e0a2f6c0f1cf 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -2094,8 +2094,11 @@ static int nvme_pci_enable(struct nvme_dev *dev)
>>=09int result =3D -ENOMEM;
>>=09struct pci_dev *pdev =3D to_pci_dev(dev->dev);
>>=20
>> -=09if (pci_enable_device_mem(pdev))
>> -=09=09return result;
>> +=09pci_lock_rescan_remove();
>> +=09result =3D pci_enable_device_mem(pdev);
>> +=09pci_unlock_rescan_remove();
>> +=09if (result)
>> +=09=09return -ENODEV;
>>=20
>>=09pci_set_master(pdev);
>>=20
>=20
> The problem may happen also with other device doing its probe and nvme ru=
nning
> its
> workqueue (and we probably have seen it in practice too). We were thinkin=
g about
> a lock
> in the pci generic code too, that's why I've put the linux-pci@ list in c=
opy.
>=20

Keith, it looks to me that this is going to fix the issue between two nvme =
driver
instances at hotplug time. This is the one we didn't cover in the first pat=
ch.

We can see the issue at driver load (so at boot) and the lock isn't taken b=
y the
generic non-rescan code. Other calls to pci_enable_device_mem aren't protec=
ted=20
neither (see Bjorns message).

What do you think about applying both for now until we have a generic fix i=
n pci?

Marta
