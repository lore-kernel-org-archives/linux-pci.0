Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:37482 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570AbbHRSnz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Aug 2015 14:43:55 -0400
MIME-Version: 1.0
In-Reply-To: <20150817224850.GM26431@google.com>
References: <1438039809-24957-1-git-send-email-yinghai@kernel.org>
	<20150817224850.GM26431@google.com>
Date: Tue, 18 Aug 2015 11:43:54 -0700
Message-ID: <CAE9FiQVbnQSiCcXoKGoGZ+WvW7fB+Z8guY=J3WJ8GEpovy=n0Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/51] PCI: Resource allocation cleanup for v4.3
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

On Mon, Aug 17, 2015 at 3:48 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Overall comments:
>
> Thanks for paying attention to your subject lines.  They are
> capitalized and punctuated quite consistently.
>
> The one-line subject is a summary.  The body of the changelog is not a
> continuation of it.  The body should stand alone even if you don't
> read the subject.  Sometimes that means you have to repeat the subject
> line in the body.  That's OK.
>
> Please use "()" when referring to functions.  You do it sometimes, but
> not always.

Thanks for checking them. Will update those changelog.

>
> I think we should talk about "required/optional" resources instead of
> "must/optional" ones.  Is "addon" a third, separate, thing?

yes, addon should be same as optional.

Actually for devices resources, could safely use required/optional resources.
those resources either required only or optional only resources.
for bridge resources, that is little confusing, as those resources could
have required part only or optional part only or have required part +
optional part.

will update changelog to make them consistent.

also will check code/comment...

Thanks

Yinghai
