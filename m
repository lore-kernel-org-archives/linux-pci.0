Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:33554 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbbGIQUJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jul 2015 12:20:09 -0400
MIME-Version: 1.0
In-Reply-To: <20150709060420.GA7465@richard>
References: <1436225966-27247-1-git-send-email-yinghai@kernel.org>
	<1436225966-27247-37-git-send-email-yinghai@kernel.org>
	<20150709033030.GA7079@richard>
	<CAE9FiQVSK9kAg-qyASpb1AoHSwQbKK33eHhFmzUjoLOftK9M4w@mail.gmail.com>
	<20150709060420.GA7465@richard>
Date: Thu, 9 Jul 2015 09:20:08 -0700
Message-ID: <CAE9FiQWnzM4x_WFZ4rXQe9db4xxXtih6_jrJDe3c-R_Djmm8Hg@mail.gmail.com>
Subject: Re: [PATCH 36/36] PCI: Don't set flags to 0 when assign resource fail
From: Yinghai Lu <yinghai@kernel.org>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	David Ahern <david.ahern@oracle.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	TJ <linux@iam.tj>, Yijing Wang <wangyijing@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 8, 2015 at 11:04 PM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
> This one is on top of the last one ? or replace the last one?

should be just before last one.

Yinghai
