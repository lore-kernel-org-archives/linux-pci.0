Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:19884 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754994Ab2DJTEg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Apr 2012 15:04:36 -0400
Message-ID: <4F848433.5080300@snewbury.org.uk>
Date: Tue, 10 Apr 2012 20:04:19 +0100
From: Steven Newbury <steve@snewbury.org.uk>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: PCI resources above 4GB
References: <1333968563.5678.19.camel@infinity> <CAErSpo7hGvJSmq4U37XN9T7ZaYn55fyy9t3ER5BBCDdQ3XZxqw@mail.gmail.com> <4F84110E.3000400@snewbury.org.uk> <CAE9FiQVHf_pcXUspOtLXx4XminmzdWja3Ra2Wh5jQRbfNOQ1eQ@mail.gmail.com> <4F8467AA.90305@snewbury.org.uk> <CAE9FiQWaop0NE7ZJu6jVW3SnxLkOJ9hRKh4xMNk64XjCAMRMMw@mail.gmail.com> <4F848357.3060007@snewbury.org.uk>
In-Reply-To: <4F848357.3060007@snewbury.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/04/12 20:00, Steven Newbury wrote:
> On 10/04/12 19:40, Yinghai Lu wrote:
>> On Tue, Apr 10, 2012 at 10:02 AM, Steven Newbury 
>> <steve@snewbury.org.uk> wrote:
>>> 
>>>> 
>>>> Can you please try attached patches with pci=nocrs?
>>>> 
>>>> for pci=use_crs, we need find safe place beyond _CRS,
>>>> because your _CRS limit under 4g.
>>>> 
>> ..
>>> So far it has changed behaviour:
>>> 
>>> Many devices now assigned above 4g.
>>> 
>>> When booted while docked i915 fails to initialise, along with 
>>> radeon as before.
>>> 
>>> When undocked i915 initialises, but radeon still fails when 
>>> hot-docked.
>>> 
>>> I've attached output of 'lspci -vvv', 'cat /proc/iomem', and 
>>> "dmesg.log" for the docked case.
>>> 
>>> Also, "dmesg-hotplug.out" for hot docking after boot.
> 
>> looks good,  please only apply
> 
>> allocate_high_at_first.patch
> 
>> Yinghai
> 
> Seems to be exactly the same.  When started docked (so I think
> both 'cards' try to claim the same preferred addresses) the
> integrated i965 GFX gets reassigned high: 120000000-12fffffff :
> 0000:00:02.0
> 
> But it's quite possible the i915 module doesn't currently handle
> this case and so fails to initialise.
> 
> I'm not sure why the Radeon doesn't get assigned a high address
> when hot-plugged..?
> 
> These are the only entries in /proc/iomem above 4GB:
> 
> 
> Booted UNDOCKED, then hot-docked
> 
> 100000000-11fffffff : System RAM 120000000-1201fffff : PCI Bus
> 0000:0b 120200000-1203fffff : PCI Bus 0000:0c 120400000-1205fffff :
> PCI Bus 0000:09
> 
> 
> Booted DOCKED
> 
> 100000000-11fffffff : System RAM 120000000-12fffffff :
> 0000:00:02.0 130000000-1301fffff : PCI Bus 0000:0b 
> 130200000-1303fffff : PCI Bus 0000:0c 130400000-1305fffff : PCI Bus
> 0000:0d 130600000-1307fffff : PCI Bus 0000:09

Output of lspci -vt:

- -[0000:00]-+-00.0  Intel Corporation Mobile PM965/GM965/GL960 Memory
Controller Hub
           +-02.0  Intel Corporation Mobile GM965/GL960 Integrated
Graphics Controller (primary)
           +-02.1  Intel Corporation Mobile GM965/GL960 Integrated
Graphics Controller (secondary)
           +-1a.0  Intel Corporation 82801H (ICH8 Family) USB UHCI
Controller #4
           +-1a.1  Intel Corporation 82801H (ICH8 Family) USB UHCI
Controller #5
           +-1a.7  Intel Corporation 82801H (ICH8 Family) USB2 EHCI
Controller #2
           +-1b.0  Intel Corporation 82801H (ICH8 Family) HD Audio
Controller
           +-1c.0-[0b]--
           +-1c.1-[0c]----00.0  Intel Corporation PRO/Wireless 4965 AG
or AGN [Kedron] Network Connection
           +-1c.3-[0d-0e]--
           +-1c.5-[09]----00.0  Broadcom Corporation NetXtreme
BCM5755M Gigabit Ethernet PCI Express
           +-1d.0  Intel Corporation 82801H (ICH8 Family) USB UHCI
Controller #1
           +-1d.1  Intel Corporation 82801H (ICH8 Family) USB UHCI
Controller #2
           +-1d.2  Intel Corporation 82801H (ICH8 Family) USB UHCI
Controller #3
           +-1d.7  Intel Corporation 82801H (ICH8 Family) USB2 EHCI
Controller #1
           +-1e.0-[03-08]--+-01.0  O2 Micro, Inc. Cardbus bridge
           |               +-01.4  O2 Micro, Inc. Firewire (IEEE 1394)
           |               \-08.0-[08]--+-00.0  Advanced Micro Devices
[AMD] nee ATI Manhattan [Mobility Radeon HD 5430 Series]
           |                            \-00.1  Advanced Micro Devices
[AMD] nee ATI Cedar HDMI Audio [Radeon HD 5400/6300 Series]
           +-1f.0  Intel Corporation 82801HM (ICH8M) LPC Interface
Controller
           +-1f.1  Intel Corporation 82801HM/HEM (ICH8M/ICH8M-E) IDE
Controller
           +-1f.2  Intel Corporation 82801HM/HEM (ICH8M/ICH8M-E) SATA
Controller [AHCI mode]
           \-1f.3  Intel Corporation 82801H (ICH8 Family) SMBus Controller
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+EhDMACgkQGcb56gMuC60VawCgj4akSUCVNoYWTZqYRGeIwN5y
CjUAnjhy23WmuxMnlA40ZXuYAq6cEN3E
=zGsf
-----END PGP SIGNATURE-----
