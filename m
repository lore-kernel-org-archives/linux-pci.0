Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:44360 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753261AbaBUVME (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Feb 2014 16:12:04 -0500
Received: by mail-ie0-f180.google.com with SMTP id ar20so1764651iec.39
        for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2014 13:12:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <B756807489D6244883AC0B799A6EEC15EAB2E8@storexdag02.amd.com>
References: <B756807489D6244883AC0B799A6EEC15EAB2E8@storexdag02.amd.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 21 Feb 2014 14:11:43 -0700
Message-ID: <CAErSpo4OkgGrrZ9anAJ2vSZJDYikv4WC6hjt4T2-mMXpGA=w6A@mail.gmail.com>
Subject: Re: Architectural question regarding IOV support in Linux 3.13.4
To: "Zytaruk, Kelly" <Kelly.Zytaruk@amd.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yu Zhao <yuzhao@google.com>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Alex, Yu]

On Fri, Feb 21, 2014 at 10:45 AM, Zytaruk, Kelly <Kelly.Zytaruk@amd.com> wrote:
>
> I am working with SR-IOV and I have a question regarding the function
> sriov_init() in ../drivers/pci/iov.c (linux versions 3.4.9 and 3.13.4)
>
> In sriov_init() the code first checks whether the PF is a Root complex
>  endpoint (0x9) or an Express Endpoint (0x0) as shown in the code
>  snippet below.  If it is neither it returns the No device error.
>
> static int sriov_init(struct pci_dev *dev, int pos)
> {
>          int i;
>          int rc;
>          int nres;
>          u32 pgsz;
>          u16 ctrl, total, offset, stride;
>          struct pci_sriov *iov;
>          struct resource *res;
>          struct pci_dev *pdev;
>
>        if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_END &&
>              pci_pcie_type(dev) != PCI_EXP_TYPE_ENDPOINT)
>                  return -ENODEV;
>
> My question is why PCI_EXP_TYPE_LEG_END (0x1) is omitted as being a
>  valid endpoint.  By excluding Legacy endpoints it fails enabling
>  SR-IOV on a VGA PF.
>
> Is there a design/specification reason why legacy was excluded or was
>  it just an assumption that VGA would never support SR-IOV?
>
> If there is no valid reason to exclude PCI_EXP_TYPE_LEG_END, I would
>  like to discuss having it included as a valid endpoint for SR-IOV.

Good question.  It looks like it's been that way since the beginning
[1], but I don't know why.  I don't see any restriction in the spec
about SR-IOV and legacy endpoints.

I also don't know whether VGA is an issue.  There are some legacy
addressing issues for [mem 0xa0000-0xbffff] and [io 0x3b0-0x3bb] and
[io 0x3c0-0x3df].  For example, when a bridge has its VGA Enable bit
set, it positively decodes [mem 0xa0000-0xbffff] even if that range
isn't included in one of the bridge windows.  I don't know whether a
VGA device is similarly allowed to decode that range even if it's not
in a BAR.  If it is, I could imagine issues if enabling SR-IOV created
several VGA VFs.

Bjorn

[1] http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?id=d1b054da8f599905f3c18a218961dcf17f9d5f13
