Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:41180 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751720Ab2GZLDQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jul 2012 07:03:16 -0400
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Huang Ying <ying.huang@intel.com>
Cc: huang ying <huang.ying.caritas@gmail.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Zheng Yan <zheng.z.yan@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>
Subject: Re: bisected regression, v3.5 -> next-20120724: PCI PM causes USB hotplug failure
References: <Pine.LNX.4.44L0.1207241312050.1164-100000@iolanthe.rowland.org>
	<87r4s0opck.fsf@nemi.mork.no> <87pq7ko532.fsf@nemi.mork.no>
	<1343190864.10311.26.camel@yhuang-dev> <87k3xskvqq.fsf@nemi.mork.no>
	<CAC=cRTOi+=49+_4VuMuBR8rTPvjXLMVhNBFbr3SHgNyxfnKQUA@mail.gmail.com>
	<874now7xi8.fsf@nemi.mork.no> <1343292851.3874.12.camel@yhuang-dev>
	<87k3xqyfm3.fsf@nemi.mork.no>
Date: Thu, 26 Jul 2012 13:02:58 +0200
In-Reply-To: <87k3xqyfm3.fsf@nemi.mork.no> (=?utf-8?Q?=22Bj=C3=B8rn?=
 Mork"'s message of "Thu, 26
	Jul 2012 12:35:32 +0200")
Message-ID: <87fw8eyecd.fsf@nemi.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjørn Mork <bjorn@mork.no> writes:

>
> Jul 26 12:20:43 nemi kernel: [  493.812266] iwlwifi 0000:03:00.0: Refused to change power state, currently in D3
> Jul 26 12:20:43 nemi kernel: [  493.812331] iwlwifi 0000:03:00.0: pci_resource_len = 0x00002000
> Jul 26 12:20:43 nemi kernel: [  493.812335] iwlwifi 0000:03:00.0: pci_resource_base = ffffc900055a4000
> Jul 26 12:20:43 nemi kernel: [  493.812339] iwlwifi 0000:03:00.0: HW Revision ID = 0x0
> Jul 26 12:20:43 nemi kernel: [  493.812350] iwlwifi 0000:03:00.0: pci_enable_msi failed(0Xffffffea)
[..]
> Jul 26 12:20:43 nemi kernel: [  493.832013] ---[ end trace fcaaf916dd43b7ca ]---
> Jul 26 12:20:43 nemi kernel: [  493.864785] iwlwifi 0000:03:00.0: bad EEPROM/OTP signature, type=OTP, EEPROM_GP=0x00000007
> Jul 26 12:20:43 nemi kernel: [  493.864791] iwlwifi 0000:03:00.0: EEPROM not found, EEPROM_GP=0xffffffff
> Jul 26 12:20:43 nemi kernel: [  493.864795] iwlwifi 0000:03:00.0: Unable to init EEPROM


Doing 

 echo on >/sys/bus/pci/devices/0000:00:1c.1/power/control

to force the brigde on and then unload/reload driver "fixes" this issue.
But I believe it is safe to say that this does not work as it should.  I
assume the bridge should have been automatically woken up first here?

And why the odd autosuspend output?  The Wifi device and bridge PM caps
look compatible to my untrained eye, and should make both D3hot and
D3cold supported ?:


        Capabilities: [c8] Power Management version 3
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-




Bjørn
