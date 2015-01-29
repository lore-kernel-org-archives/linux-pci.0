Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foundry.eraalaska.net ([12.12.105.40]:55651 "EHLO
	foundry.eraalaska.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005AbbA2Tq2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jan 2015 14:46:28 -0500
Received: From approach.ravnalaska.net (12.12.105.49) by foundry.eraalaska.net (MAILFOUNDRY) id g//YgKfvEeS8bgAl for linux-pci@vger.kernel.org; Thu, 29 Jan 2015 19:46:28 -0000 (GMT)
Received: from israel.frontierflying.com (unknown [10.9.1.59])
	by approach.ravnalaska.net (Postfix) with ESMTPSA id 222D01137AFA
	for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2015 10:46:28 -0900 (AKST)
From: Israel Brewster <israel@ravnalaska.net>
Content-Type: multipart/mixed; boundary="Apple-Mail=_24BEDBA4-02B1-4BE3-8730-88DDAF6DFA5C"
Subject: CentOS/Kernel 3.18.4/Thunderbolt2
Message-Id: <262B8C88-E706-4538-99D8-4E5058BE646D@ravnalaska.net>
Date: Thu, 29 Jan 2015 10:46:27 -0900
To: linux-pci@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--Apple-Mail=_24BEDBA4-02B1-4BE3-8730-88DDAF6DFA5C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

My company recently purchased and installed a new SuperMicro server with =
a Thunderbolt 2 (Falcon Ridge) card installed, specifically an =
AOC-TBT-DSL5320. I then installed CentOS 6, and, since to my =
understanding thunderbolt support is only in more recent kernels, I went =
ahead and upgraded the kernel to version 3.18.4 from ElRepo. However, I =
have not seen any indication yet that Thunderbolt is working - although =
I may just not be looking in the right place. Over on Google+ Greg =
Kroah-Hartman indicated that I need the PCI hot plug controller driver =
enabled, and Matthew Garrett indicated that I specifically need the ACPI =
PCI hotplug driver rather than the native PCIe hotplug driver. To check, =
I ran the following command:

egrep -i HOTPLUG /boot/config-3.18.4-1.el6.elrepo.x86_64

Which returned the following potentially relevant results:

CONFIG_ACPI_HOTPLUG_CPU=3Dy
CONFIG_ACPI_HOTPLUG_MEMORY=3Dy
CONFIG_HOTPLUG_PCI_PCIE=3Dy
CONFIG_HOTPLUG_PCI=3Dy

but also the following:

# CONFIG_HOTPLUG_PCI_ACPI is not set
# CONFIG_HOTPLUG_PCI_CPCI is not set=20

So perhaps that's the entire problem - that CONFIG_HOTPLUG_PCI_ACPI is =
not set? If so, what's going to be the easiest solution? I'm willing to =
try recompiling the kernel, if someone could point me to a good guide, =
but I haven't done so before (at least, not on Linux. I've re-compiled =
the kernel on OpenBSD many times).

-----------------------------------------------
Israel Brewster
Systems Analyst II
Ravn Alaska
5245 Airport Industrial Rd
Fairbanks, AK 99709
(907) 450-7293
-----------------------------------------------



--Apple-Mail=_24BEDBA4-02B1-4BE3-8730-88DDAF6DFA5C
Content-Disposition: attachment;
	filename="Israel Brewster.vcf"
Content-Type: text/directory;
	name="Israel Brewster.vcf"
Content-Transfer-Encoding: quoted-printable

BEGIN:VCARD=0D=0AVERSION:3.0=0D=0AN:Brewster;Israel;;;=0D=0AFN:Israel=20=
Brewster=0D=0AORG:Frontier=20Flying=20Service;MIS=0D=0ATITLE:PC=20=
Support=20Tech=20II=0D=0A=
EMAIL;type=3DINTERNET;type=3DWORK;type=3Dpref:israel@frontierflying.com=0D=
=0ATEL;type=3DWORK;type=3Dpref:907-450-7293=0D=0A=
item1.ADR;type=3DWORK;type=3Dpref:;;5245=20Airport=20Industrial=20=
Wy;Fairbanks;AK;99701;=0D=0Aitem1.X-ABADR:us=0D=0ACATEGORIES:General=0D=0A=
X-ABUID:36305438-95EA-4410-91AB-45D16CABCDDC\:ABPerson=0D=0AEND:VCARD=0D=0A=

--Apple-Mail=_24BEDBA4-02B1-4BE3-8730-88DDAF6DFA5C
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii




--Apple-Mail=_24BEDBA4-02B1-4BE3-8730-88DDAF6DFA5C--
