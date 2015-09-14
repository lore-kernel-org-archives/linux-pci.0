Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:32782 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbbINVh3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2015 17:37:29 -0400
MIME-Version: 1.0
In-Reply-To: <20150914202123.GA27964@google.com>
References: <1440138067-4314-1-git-send-email-yinghai@kernel.org>
	<1440138067-4314-5-git-send-email-yinghai@kernel.org>
	<20150914202123.GA27964@google.com>
Date: Mon, 14 Sep 2015 14:37:28 -0700
Message-ID: <CAE9FiQXr3vqusta0Tb35BovbWh7jDZ5uVQer741ioWKhYr7xmA@mail.gmail.com>
Subject: Re: [PATCH v4 04/52] PCI: Optimize bus min_align/size calculation
 during sizing
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 14, 2015 at 1:21 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> I spent a couple hours trying to understand the v3 version of this
> patch, and I gave you some detailed examples and questions.  If you
> want me to look at v4, I expect you to try to clarify the changelog to
> help answer those questions.

you example is  addressed in following patch that support alt_size

and this patch only handle min_align searching for size is not equal to
align.

>
> The goal is that someone with reasonable familiarity with Linux and
> PCI would be able to read the changelogs and understand what happened,
> without having to search out all the email discussions.

Agreed. But changelog for this should not talk alt_size support in
following patch.

Also please let me know if you prefer to reviewing v5 that would be
re-based on v4.3-rc1
instead of v4. or I could wait to post v5 after you finish v4.

Thanks

Yinghai
