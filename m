Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:34066 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524AbbHSG6o (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Aug 2015 02:58:44 -0400
MIME-Version: 1.0
In-Reply-To: <20150818041429.GY26431@google.com>
References: <1438039809-24957-1-git-send-email-yinghai@kernel.org>
	<1438039809-24957-33-git-send-email-yinghai@kernel.org>
	<20150818041429.GY26431@google.com>
Date: Tue, 18 Aug 2015 23:58:44 -0700
Message-ID: <CAE9FiQUaNBYphhBhJWbePjxHZzCnXS5Qtj9zvUqy=x7qDQGahQ@mail.gmail.com>
Subject: Re: [PATCH v3 32/51] resources: Split out __allocate_resource()
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

On Mon, Aug 17, 2015 at 9:14 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Mon, Jul 27, 2015 at 04:29:50PM -0700, Yinghai Lu wrote:
>> It will not hold lock, so we could use it in other functions that
>> hold the resource lock already.
>
> What's the benefit of this patch?  Does it fix something?  Does it add some
> functionality we need?

will use it in following patch.
