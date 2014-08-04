Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nbfkord-smmo03.seg.att.com ([209.65.160.84]:61805 "EHLO
	nbfkord-smmo03.seg.att.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751033AbaHDPp1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 4 Aug 2014 11:45:27 -0400
Message-ID: <53DFAA8C.2010602@solarflare.com>
Date: Mon, 4 Aug 2014 16:45:16 +0100
From: Edward Cree <ecree@solarflare.com>
MIME-Version: 1.0
To: Ethan Zhao <ethan.kernel@gmail.com>
CC: linux-pci <linux-pci@vger.kernel.org>,
	Alexander Duyck <alexander.h.duyck@intel.com>,
	Don Dutile <ddutile@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Vasundhara Volam <vasundhara.volam@emulex.com>
Subject: Re: [PATCH] PCI: handle pci_sriov_set_totalvfs(dev, 0)
References: <53D9288B.5030302@solarflare.com> <53D93407.8040308@redhat.com> <53D93848.7070203@solarflare.com> <53D9602A.4010406@intel.com> <53DA3180.5040302@solarflare.com> <alpine.LFD.2.03.1407311500570.16821@solarflare.com> <CABawtvPwxovKV==8RVCL1OcsdfnZDDjr=d1uYp-A=bAzYbmKww@mail.gmail.com> <53DB84E6.1070206@solarflare.com> <107835EF-8941-4621-952F-E1583F7E3636@gmail.com>
In-Reply-To: <107835EF-8941-4621-952F-E1583F7E3636@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/08/14 01:25, Ethan Zhao wrote:
> 在 2014年8月1日，下午8:15，Edward Cree <ecree@solarflare.com> 写道：
>> On 01/08/14 04:51, Ethan Zhao wrote:
>>> So far seems no driver call pci_sriov_set_totalvfs() with numvfs = 0
>>> and the patch will change the behavior of the drivers, but it will
>>> definitely change the test cases and documents related to IOV.
>> As for test cases and documents, I can't find any in the kernel tree
> I mean some test cases or doc that are out of kernel tree ... such as some Distro, 
> not only Hardware vendors.
I was under the impression that we don't care about breaking out-of-tree
code.  Distros should be (and it looks like most are) using the
kernel-doc to generate their documentation, and the kernel-doc doesn't
say anything about what happens when passing 0.

-Edward
