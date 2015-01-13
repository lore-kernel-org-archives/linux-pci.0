Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:45866 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbbAMSFF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 13 Jan 2015 13:05:05 -0500
Received: by mail-oi0-f45.google.com with SMTP id x69so3551916oia.4
        for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2015 10:05:05 -0800 (PST)
Date: Tue, 13 Jan 2015 11:05:02 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: benh@au1.ibm.com, gwshan@linux.vnet.ibm.com,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V10 00/17] Enable SRIOV on Power8
Message-ID: <20150113180502.GC2776@google.com>
References: <1419227677-12312-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20141222060522.GA12285@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141222060522.GA12285@richard>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 22, 2014 at 02:05:22PM +0800, Wei Yang wrote:
> Bjorn,
> 
> This patch set is tested on 3.19-rc1 and with the offset/stride update patch.
> 
> I see your comment on the MEM64 issue, so if that is reverted, this
> patch set will not work. While I think we can work in parallel, I sent it here
> for more comment and to see whether I understand your previous comments
> correctly.
> 
> I will work with Yinghai to find a way to fix the bug 85491, hope linux kernel
> could handle both cases.

OK.  The autobuilder found some minor issues, so I'll look for a v11
posting that fixes those.  Please pick up the changelogs from my
pci/virtualization branch because I rewrapped them so they fit in 80
columns when shown by "git log".

Bjorn
