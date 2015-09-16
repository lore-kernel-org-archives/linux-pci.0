Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:32950 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689AbbIPTd6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Sep 2015 15:33:58 -0400
MIME-Version: 1.0
In-Reply-To: <CAErSpo5VAb_YRpz7PEzuZ9AthAQ67quMKE3Y0dfMHVKjw0OTxA@mail.gmail.com>
References: <1440138067-4314-1-git-send-email-yinghai@kernel.org>
	<1440138067-4314-5-git-send-email-yinghai@kernel.org>
	<20150914202123.GA27964@google.com>
	<CAE9FiQXr3vqusta0Tb35BovbWh7jDZ5uVQer741ioWKhYr7xmA@mail.gmail.com>
	<CAErSpo5VAb_YRpz7PEzuZ9AthAQ67quMKE3Y0dfMHVKjw0OTxA@mail.gmail.com>
Date: Wed, 16 Sep 2015 12:33:57 -0700
Message-ID: <CAE9FiQWbRuFvXiYif7_SiLW17m=WcnM0EZZHsjwO5W6F0K6kwQ@mail.gmail.com>
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

On Tue, Sep 15, 2015 at 7:57 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
> Any future series you post should be based on the most recent -rc1 at
> the time.  I apply patches to branches based on -rc1 unless they
> actually depend on something merged after -rc1.

ok, will post v5 based on v4.3-rc1.

Thanks

Yinghai
