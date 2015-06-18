Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:35258 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900AbbFRS2E (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jun 2015 14:28:04 -0400
MIME-Version: 1.0
In-Reply-To: <20150618161258.32739.29646.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150618161207.32739.62577.stgit@bhelgaas-glaptop2.roam.corp.google.com>
	<20150618161258.32739.29646.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Date: Thu, 18 Jun 2015 11:28:03 -0700
Message-ID: <CAE9FiQXRC8edE73tRMF231fcodzEhQKkzNor7cyCMjPrC_xtog@mail.gmail.com>
Subject: Re: [PATCH 4/4] PCI: pciehp: Inline the "handle event" functions into
 the ISR
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Rajat Jain <rajatja@google.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 18, 2015 at 9:12 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> The pciehp_handle_*() functions (pciehp_handle_attention_button(), etc.)
> only contain a line or two of useful code, so it's clumsy to put
> them in separate functions.  All they so is add an event to a work queue,
> and it's clearer to see that directly in the ISR.

Yes. That make the code more readable.

For all 4 patches:

Acked-by: Yinghai Lu <yinghai@kernel.org>
