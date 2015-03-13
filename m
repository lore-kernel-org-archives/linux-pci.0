Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48955 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752889AbbCMNDR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 13 Mar 2015 09:03:17 -0400
Message-ID: <5502E005.7000406@redhat.com>
Date: Fri, 13 Mar 2015 14:03:01 +0100
From: Paolo Bonzini <pbonzini@redhat.com>
MIME-Version: 1.0
To: Fam Zheng <famz@redhat.com>
CC: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Linux Virtualization <virtualization@lists.linux-foundation.org>,
	mst@redhat.com
Subject: Re: [RFC PATCH] PCI: Disable MSI/MSI-X only if device is shutdown
References: <1426137682-12287-1-git-send-email-famz@redhat.com> <5501BCF7.9080004@redhat.com> <20150312232104.GA32054@ad.nay.redhat.com>
In-Reply-To: <20150312232104.GA32054@ad.nay.redhat.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 13/03/2015 00:21, Fam Zheng wrote:
>> I think the bug here is also that virtio-pci
>> is not defining a .shutdown callback.  It should define one and call
>> free_irq (for INTX) and pci_disable_msix.
> 
> It's not enough. The device has to know we disabled msix, otherwise it will
> send us IRQ, which is wrong.

You can use pci_intx to disable INTX too.  So I think this is a
virtio-pci bug.

Paolo
