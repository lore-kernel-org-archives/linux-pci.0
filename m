Return-Path: <SRS0=/dOL=PT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F8BC43387
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 17:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C89620652
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 17:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="gIHBzQQT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbfAKRZK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:25:10 -0500
Received: from mta-01.yadro.com ([89.207.88.251]:41972 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729121AbfAKRZK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Jan 2019 12:25:10 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id D6A114196E;
        Fri, 11 Jan 2019 17:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:in-reply-to:mime-version:user-agent
        :date:date:message-id:from:from:references:subject:subject
        :received:received:received; s=mta-01; t=1547227505; x=
        1549041906; bh=/A4KTcafGlySOukcou+Pllxk914C5skESiD4yE76b+4=; b=g
        IHBzQQT3efM3ZFnIc06TR3HStudnnIs0f1DB/pSfuQG+se3MzAN4A/TtFhBs1UXf
        SQ30UfaAmU9YOflkIunyULBH3QkJNQw6VPxOt/PXDm7JOhMso6V5Dx+wemV4Y+pX
        WJJi92Rz5bjhPEZJd3hht9g7nOQCB2/cwUjHN+EKSs=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cB0z36KNG6My; Fri, 11 Jan 2019 20:25:05 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 4D4F941969;
        Fri, 11 Jan 2019 20:25:05 +0300 (MSK)
Received: from [172.17.15.60] (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 11
 Jan 2019 20:25:04 +0300
Subject: Re: [PATCH RFC 1/4] PCI: hotplug: Add parameter to put devices to
 reset during rescan
To:     Rajat Jain <rajatja@google.com>
CC:     linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, <linux@yadro.com>
References: <20180914161404.4685-1-s.miroshnichenko@yadro.com>
 <20180914161404.4685-2-s.miroshnichenko@yadro.com>
 <CACK8Z6F1-P+SDYHx6x3zitSFh2iEPhQtY-Vdhz6Qwkt9=0XTjA@mail.gmail.com>
 <d4dd901b-0602-d764-1d79-6dec4ef8cdb4@yadro.com>
 <CACK8Z6H9PqRLtg+15X4VfcT7hwZL7GrqQyAaCJbd5biom_X6+A@mail.gmail.com>
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Openpgp: preference=signencrypt
Autocrypt: addr=s.miroshnichenko@yadro.com; prefer-encrypt=mutual; keydata=
 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
 lHi50np+KDDPzZS51tw=
Message-ID: <d74eea88-a58f-b429-8a2a-3a9acd53b499@yadro.com>
Date:   Fri, 11 Jan 2019 20:24:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CACK8Z6H9PqRLtg+15X4VfcT7hwZL7GrqQyAaCJbd5biom_X6+A@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="WwEQsgmxjPR41VeN9t1oSyIKVS7bgyTpw"
X-Originating-IP: [172.17.15.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--WwEQsgmxjPR41VeN9t1oSyIKVS7bgyTpw
Content-Type: multipart/mixed; boundary="at7Tl7TO2Irl4VoATpXk7uISRysH0B7GW";
 protected-headers="v1"
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: Rajat Jain <rajatja@google.com>
Cc: linux-pci <linux-pci@vger.kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, linux@yadro.com
Message-ID: <d74eea88-a58f-b429-8a2a-3a9acd53b499@yadro.com>
Subject: Re: [PATCH RFC 1/4] PCI: hotplug: Add parameter to put devices to
 reset during rescan
References: <20180914161404.4685-1-s.miroshnichenko@yadro.com>
 <20180914161404.4685-2-s.miroshnichenko@yadro.com>
 <CACK8Z6F1-P+SDYHx6x3zitSFh2iEPhQtY-Vdhz6Qwkt9=0XTjA@mail.gmail.com>
 <d4dd901b-0602-d764-1d79-6dec4ef8cdb4@yadro.com>
 <CACK8Z6H9PqRLtg+15X4VfcT7hwZL7GrqQyAaCJbd5biom_X6+A@mail.gmail.com>
In-Reply-To: <CACK8Z6H9PqRLtg+15X4VfcT7hwZL7GrqQyAaCJbd5biom_X6+A@mail.gmail.com>

--at7Tl7TO2Irl4VoATpXk7uISRysH0B7GW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello Rajat,

Sorry for the long absence! I've finally reworked the patchset heavily
to address the proposals and issues (v2, sent today to linux-pci), so
now I can give a better answer:

On 9/19/18 12:22 AM, Rajat Jain wrote:
> Hi Sergey,
>=20
> Sorry, I have one more basic question: The PCI express hierarchy is
> made up from PCI express switches and end points, so essentially there
> are only point to point links (except the switch internal logicl bus
> on which you cannot hotplug anything). The device being hotplugged
> shall be plugged onto a downstream port of a switch (or root port), so
> there shall be no other device on that bus (since each downstream port
> gets its own secondary bus number, and its own share of resources). So
> it seems to me, that in this case, IF the resources at the downstream
> port are not big enough, you will need to re-program the switch to get
> resources to this downstream port, by stealing from *another*
> downstream port. Is this correct understanding of the problem that you
> are trying to solve?

To some extent, yes.

The patchset is intended to work with the "pci=3Drealloc" command line
argument, in this case the kernel will set bridge windows of zero size
for empty buses. And for non-empty slots their bridge windows would be
equal to to a sum of children BARs + alignments.

After hotplugging a device into a downstream port of a switch, first the
kernel needs to allocate a bridge window for this downstream port.
Neighboring empty slots have nothing to steal from, and busy slots can
not be shrunk (because all working devices must remain working after a
hotplug event).

So the switch's bridge window should be extended to fit the bridge
window for the downstream port to fit the BARs of the hotplugged device.

And here is the problem: switch's neighbors most probably reside very
closely, and they can be movable (support movable BARs, or don't have
connected drivers), immovable or movable in hard limits (depending on
location of children immovable BARs).

This patchset releases bridge windows and everything movable, marks the
immovable BARs with IORESOURCE_PCI_FIXED, and calculates for every
bridge its "fixed range" - the lowest and the highest addresses of
children immovable BARs to determine how far away we can move these
bridge windows.

Then the re-assignment starts. If it fails (the root bridge window is
not big enough to fit all the BARs or can't squeeze the new BARs between
the immovable ones), the hotplugged devices are to be marked with the
new flag PCI_DEV_IGNORE one by one, and re-assignment restarts.

Then the kernel writes the recalculated BAR addresses and bridge windows
into the ports and endpoints, and enables the MEM and IO flags if needed.=


Please ask if I haven't covered some aspects!

Best regards,
Serge

>=20
> Thanks,
>=20
> Rajat
>=20
>=20
>=20
> On Mon, Sep 17, 2018 at 2:25 PM Sergey Miroshnichenko
> <s.miroshnichenko@yadro.com> wrote:
>>
>> Hello Rajat,
>>
>> On 9/17/18 10:00 PM, Rajat Jain wrote:
>>> On Fri, Sep 14, 2018 at 9:21 AM Sergey Miroshnichenko
>>> <s.miroshnichenko@yadro.com> wrote:
>>>>
>>>> Introduce a new command line option "pci=3Dpcie_movable_bars" that i=
ndicates
>>>> support of PCIe hotplug without prior reservation of memory regions =
by
>>>> BIOS/bootloader.
>>>>
>>>> If a new PCIe device has been hot-plugged between two active ones, w=
hich
>>>> have no (or not big enough) gap between their BARs, allocating new B=
ARs
>>>> requires to move BARs of the following working devices:
>>>
>>> I think this is a great problem to solve. I have some questions (not
>>> objections, but trying to understand what are the limitations of the
>>> solution being proposed):
>>>
>>> * What about hot-pluggable root ports? Would this help (I'm guessing =
not)?
>>>
>>
>> We don't have a hardware that is able to handle a hotplug directly int=
o
>> a root port (but we'll find) - there are intermediate bridges always, =
so
>> I can't provide proofs right now. But after a thought experiment I can=
't
>> see any obstacles, so just need to verify.
>>
>>> * What about situations where the root port itself does not have
>>> enough resources for the new device being inserted. I'm guessing we
>>> are not going to expand root port allocation in those cases. But do w=
e
>>> fail gracefully rejecting the hotplug by not assigning it resources,
>>> or do we manage to screw up the already working healthy devices (whil=
e
>>> attempting to move them)?
>>>
>>
>> Thanks for a great point! The code currently is too simplistic to hand=
le
>> this case properly, and though it never happened to us yet, but I'm su=
re
>> it can kick off a working device to use its resources for a hotplugged=

>> one. The struct resource doesn't have a "priority" field, so probably =
I
>> need to check the status of the resource allocation procedure and retr=
y
>> it without some of new hotplugged devices in case of fail.
>>
>>> * What about non-memory resources? E.g. cards may have pci bridges or=

>>> switches on them, and they may need extra PCI bus numbers. Does this
>>> help that use case?
>>
>> Actually, this patchset is a part of our bigger work on hotplugging
>> bridges full of bridges full of NVME and GPU devices. And in case of
>> success here I was planning to submit the last part (hotplugging
>> bridges), which includes the movement of bus numbers - similar to BARs=
,
>> but more awkward, with PCIe devices renaming and re-building the
>> /sys/bus/pci and /proc/pci, otherwise the lspci tool gets mad.
>>
>> By device renaming I mean the "/dev/nvme0n1p1" and "eth0" will remain
>> the same, but underlying "nvme 0022:04:00.0" and "tg3 0001:06:00.1" ma=
y
>> change. In this regard I don't know which UDEV action is the best here=
 -
>> it's neither "add", "remove" nor "change".
>>
>>
>> Also I've just realized that should take a closer look and check if MS=
Is
>> are also needs to be reallocated.
>>
>>>>
>>>> 1)                   dev 4
>>>>                        |
>>>>                        v
>>>> .. |  dev 3  |  dev 3  |  dev 5  |  dev 7  |
>>>> .. |  BAR 0  |  BAR 1  |  BAR 0  |  BAR 0  |
>>>>
>>>> 2)                             dev 4
>>>>                                  |
>>>>                                  v
>>>> .. |  dev 3  |  dev 3  | -->           --> |  dev 5  |  dev 7  |
>>>> .. |  BAR 0  |  BAR 1  | -->           --> |  BAR 0  |  BAR 0  |
>>>>
>>>> 3)
>>>>
>>>> .. |  dev 3  |  dev 3  |  dev 4  |  dev 4  |  dev 5  |  dev 7  |
>>>> .. |  BAR 0  |  BAR 1  |  BAR 0  |  BAR 1  |  BAR 0  |  BAR 0  |
>>>>
>>>> Not only BARs, but also bridge windows can be updated during a PCIe =
rescan,
>>>> threatening all memory transactions during this procedure, so the PC=
I
>>>> subsystem will instruct the drivers to pause by calling the reset_pr=
epare()
>>>> and reset_done() callbacks.
>>>>
>>>> If a device may be affected by BAR movement, the BAR changes trackin=
g must
>>>> be implemented in its driver.
>>>
>>> This is quite a big thing right? I expect that this will break a lot
>>> of drivers because
>>> (a) they may not have reset_prepare() and reset_done() callbacks (I
>>> grepped in the sources and seems only 4 support it?).
>>> (b) Now, it is expected that in the reset_done() the drivers should
>>> re-read the BAR and remap any memory resources that may have changed.=

>>> Note this may also include cleaning up any existing resource mappings=

>>> that they had before they were paused. Not sure if this was the
>>> semantics of reset_done() already, or may be it was, I'm just not
>>> sure.
>>>
>>
>> Yes, this is the most painful part: all the drivers that may be affect=
ed
>> with BARs getting moved, must be prepared in this way. Luckily, these
>> operations have distinct patterns, just like power management callback=
s
>> like runtime_suspend()/runtime_resume() and friends.
>>
>> Just a few minutes earlier in this thread I've wrote to Sam why we thi=
nk
>> this approach still can be used even with a minimal subset of drivers
>> being prepared: for now we've limited the configurations of hotplug
>> usage to non-root bridges and to domains with similar devices. If this=

>> concept looks viable to the community, we'll be happy to share the
>> patches for the nvme, ixgbe and tg3 drivers (and a bit later - for
>> xhci). Right now these are the only drivers _we_ need on our ppc64
>> (PowerNV) and x86_64 servers.
>>
>>> Thanks,
>>>
>>> Rajat
>>>
>>
>> Thanks for the review!
>>
>> Best regards,
>> Serge
>>
>>>>
>>>> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
>>>> ---
>>>>  .../admin-guide/kernel-parameters.txt         |  6 +++
>>>>  drivers/pci/pci.c                             |  2 +
>>>>  drivers/pci/probe.c                           | 43 ++++++++++++++++=
+++
>>>>  include/linux/pci.h                           |  1 +
>>>>  4 files changed, 52 insertions(+)
>>>>
>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Docum=
entation/admin-guide/kernel-parameters.txt
>>>> index 64a3bf54b974..f8132a709061 100644
>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>> @@ -3311,6 +3311,12 @@
>>>>                                 bridges without forcing it upstream.=
 Note:
>>>>                                 this removes isolation between devic=
es and
>>>>                                 may put more devices in an IOMMU gro=
up.
>>>> +               pcie_movable_bars       Arrange a space at runtime f=
or BARs of
>>>> +                               hotplugged PCIe devices - usable if =
bootloader
>>>> +                               doesn't reserve memory regions for t=
hem. Freeing
>>>> +                               a space may require moving BARs of a=
ctive devices
>>>> +                               to higher addresses, so device drive=
rs will be
>>>> +                               paused during rescan.
>>>>
>>>>         pcie_aspm=3D      [PCIE] Forcibly enable or disable PCIe Act=
ive State Power
>>>>                         Management.
>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>> index 1835f3a7aa8d..5f07a59b5924 100644
>>>> --- a/drivers/pci/pci.c
>>>> +++ b/drivers/pci/pci.c
>>>> @@ -6105,6 +6105,8 @@ static int __init pci_setup(char *str)
>>>>                                 pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS=
);
>>>>                         } else if (!strncmp(str, "disable_acs_redir=3D=
", 18)) {
>>>>                                 disable_acs_redir_param =3D str + 18=
;
>>>> +                       } else if (!strncmp(str, "pcie_movable_bars"=
, 17)) {
>>>> +                               pci_add_flags(PCI_MOVABLE_BARS);
>>>>                         } else {
>>>>                                 printk(KERN_ERR "PCI: Unknown option=
 `%s'\n",
>>>>                                                 str);
>>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>>> index 201f9e5ff55c..bdaafc48dc4c 100644
>>>> --- a/drivers/pci/probe.c
>>>> +++ b/drivers/pci/probe.c
>>>> @@ -3138,6 +3138,45 @@ unsigned int pci_rescan_bus_bridge_resize(str=
uct pci_dev *bridge)
>>>>         return max;
>>>>  }
>>>>
>>>> +/*
>>>> + * Put all devices of the bus and its children to reset
>>>> + */
>>>> +static void pci_bus_reset_prepare(struct pci_bus *bus)
>>>> +{
>>>> +       struct pci_dev *dev;
>>>> +
>>>> +       list_for_each_entry(dev, &bus->devices, bus_list) {
>>>> +               struct pci_bus *child =3D dev->subordinate;
>>>> +
>>>> +               if (child) {
>>>> +                       pci_bus_reset_prepare(child);
>>>> +               } else if (dev->driver &&
>>>> +                          dev->driver->err_handler &&
>>>> +                          dev->driver->err_handler->reset_prepare) =
{
>>>> +                       dev->driver->err_handler->reset_prepare(dev)=
;
>>>> +               }
>>>> +       }
>>>> +}
>>>> +
>>>> +/*
>>>> + * Complete the reset of all devices for the bus and its children
>>>> + */
>>>> +static void pci_bus_reset_done(struct pci_bus *bus)
>>>> +{
>>>> +       struct pci_dev *dev;
>>>> +
>>>> +       list_for_each_entry(dev, &bus->devices, bus_list) {
>>>> +               struct pci_bus *child =3D dev->subordinate;
>>>> +
>>>> +               if (child) {
>>>> +                       pci_bus_reset_done(child);
>>>> +               } else if (dev->driver && dev->driver->err_handler &=
&
>>>> +                          dev->driver->err_handler->reset_done) {
>>>> +                       dev->driver->err_handler->reset_done(dev);
>>>> +               }
>>>> +       }
>>>> +}
>>>> +
>>>>  /**
>>>>   * pci_rescan_bus - Scan a PCI bus for devices
>>>>   * @bus: PCI bus to scan
>>>> @@ -3151,8 +3190,12 @@ unsigned int pci_rescan_bus(struct pci_bus *b=
us)
>>>>  {
>>>>         unsigned int max;
>>>>
>>>> +       if (pci_has_flag(PCI_MOVABLE_BARS))
>>>> +               pci_bus_reset_prepare(bus);
>>>>         max =3D pci_scan_child_bus(bus);
>>>>         pci_assign_unassigned_bus_resources(bus);
>>>> +       if (pci_has_flag(PCI_MOVABLE_BARS))
>>>> +               pci_bus_reset_done(bus);
>>>>         pci_bus_add_devices(bus);
>>>>
>>>>         return max;
>>>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>>>> index 6925828f9f25..a8cb1a367c34 100644
>>>> --- a/include/linux/pci.h
>>>> +++ b/include/linux/pci.h
>>>> @@ -847,6 +847,7 @@ enum {
>>>>         PCI_ENABLE_PROC_DOMAINS =3D 0x00000010,   /* Enable domains =
in /proc */
>>>>         PCI_COMPAT_DOMAIN_0     =3D 0x00000020,   /* ... except doma=
in 0 */
>>>>         PCI_SCAN_ALL_PCIE_DEVS  =3D 0x00000040,   /* Scan all, not j=
ust dev 0 */
>>>> +       PCI_MOVABLE_BARS        =3D 0x00000080,   /* Runtime BAR rea=
ssign after hotplug */
>>>>  };
>>>>
>>>>  /* These external functions are only available when PCI support is =
enabled */
>>>> --
>>>> 2.17.1
>>>>


--at7Tl7TO2Irl4VoATpXk7uISRysH0B7GW--

--WwEQsgmxjPR41VeN9t1oSyIKVS7bgyTpw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEHW7T7ovP/cFp8+b3DHQ+aNFTs7UFAlw40XAACgkQDHQ+aNFT
s7UNFA/+MTZt2qgRWtdmpo0P9I/V0vjs9gXh21dbRZeqZktYblqTBWD45TNcaAfi
Rfhfcb8NGk+dqAK7oAJ6naCvmFcNulqI6vedCzyI5okS63Ef4xEaA2nLsDI512sm
dLY0/K4BdBrvBvsVLhJ/bvCpB/c73vXLIn/k6WSzCWKKOIVFFwXEeD9FNCV+Qg6y
vKZ0G67Ksl7jvaDWljZ7Kx3VIIrfMlHdHTkgyW9F4zMJCSHGDmeWJ8ELPI+Ov+TJ
Cu9CTlnytjgGhQc2Zfung5SRxreVHM1Tq0niSHIK4tTWa6qWPrK0ux+Y1V2E7p1v
/L7FBJhmm0OI5jZH10AOxGjTqKbomFz9r9fGTkZ9/7QJDav4YGCzH3YSEx1Vzud/
4yXXYkBqexlcBK72N6TbSHoPlRtEoSoV60Yyu3c+gDLWxTSHK0sGdLCylS5K/uDK
wQ+s2ShcktqRCGvhkXY22J7g1DMLMFMWpf9zJfG6TU1UL+8MacdA5Rdce+7QSp6N
eAkHr5f9vn5JIsWtX+pSP+vsgIKoNyrl4FPPcakQPCqXE8siWOBk1xpjUht8ZPOv
ogvNxWopnIs97IxmIZxpMmcZof6a1C6O3y+/Mrr6Qd7a1v79ARBwrOwbM8pmyRMy
trKZpOgFy9HaMTvB+RIx+ZYRqjE41w57xqqzY7NAmG2qXcLTmxo=
=mNQu
-----END PGP SIGNATURE-----

--WwEQsgmxjPR41VeN9t1oSyIKVS7bgyTpw--
