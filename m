Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:35855 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbbJBXQv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 Oct 2015 19:16:51 -0400
MIME-Version: 1.0
In-Reply-To: <560F0DD1.60304@oracle.com>
References: <1443678807-786-1-git-send-email-yinghai@kernel.org>
	<1443678807-786-2-git-send-email-yinghai@kernel.org>
	<1443816007.7936.24.camel@oracle.com>
	<CAE9FiQX=qEO53rSw9bQv-2-3sSmYUO3YCJyj8m6mSNSTed3zEA@mail.gmail.com>
	<560F0DD1.60304@oracle.com>
Date: Fri, 2 Oct 2015 16:16:50 -0700
Message-ID: <CAE9FiQV4HnmyosmM76Hax2oaDiP7QSVdVt8kFt6ki2Ee-xhgKA@mail.gmail.com>
Subject: Re: [PATCH v6 01/53] sparc/PCI: Add mem64 resource parsing for root bus
From: Yinghai Lu <yinghai@kernel.org>
To: Khalid Aziz <khalid.aziz@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 2, 2015 at 4:05 PM, Khalid Aziz <khalid.aziz@oracle.com> wrote:
> On 10/02/2015 04:05 PM, Yinghai Lu wrote:

> I still see lots of "no compatible
> bridge window" messages but overlapping address ranges are no longer
> reserved

Please send boot log to me, I'd like to fix them.

Thanks

Yinghai
