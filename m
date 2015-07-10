Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:33666 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbbGJCs2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jul 2015 22:48:28 -0400
MIME-Version: 1.0
In-Reply-To: <20150710023014.GA16104@richard>
References: <1436225966-27247-1-git-send-email-yinghai@kernel.org>
	<1436225966-27247-37-git-send-email-yinghai@kernel.org>
	<20150709033030.GA7079@richard>
	<CAE9FiQVSK9kAg-qyASpb1AoHSwQbKK33eHhFmzUjoLOftK9M4w@mail.gmail.com>
	<20150709060420.GA7465@richard>
	<CAE9FiQWnzM4x_WFZ4rXQe9db4xxXtih6_jrJDe3c-R_Djmm8Hg@mail.gmail.com>
	<20150710023014.GA16104@richard>
Date: Thu, 9 Jul 2015 19:48:27 -0700
Message-ID: <CAE9FiQVaoFWk9A1vyqDgOu_eqWRcZkwrWRQ0CXpcAJ4VBOgwaQ@mail.gmail.com>
Subject: Re: [PATCH 36/36] PCI: Don't set flags to 0 when assign resource fail
From: Yinghai Lu <yinghai@kernel.org>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	TJ <linux@iam.tj>, Yijing Wang <wangyijing@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 9, 2015 at 7:30 PM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
> If you could update your for-pci-v4.3-next branch, that would be more
> convenient for me to do the test.

Just updated that branch, please check it.

Thanks

Yinghai
