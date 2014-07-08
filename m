Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:51213 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800AbaGHWu2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jul 2014 18:50:28 -0400
Received: by mail-ig0-f173.google.com with SMTP id h18so58211igc.0
        for <linux-pci@vger.kernel.org>; Tue, 08 Jul 2014 15:50:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140708222442.GA13700@google.com>
References: <1404420379-20983-1-git-send-email-yinghai@kernel.org>
	<20140708222442.GA13700@google.com>
Date: Tue, 8 Jul 2014 15:50:27 -0700
Message-ID: <CAE9FiQV_EarZgBuGEz+s_39LE3AJBL_PLupL8WkO7Rw3mD76Dw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] PCI: Fix bus align checking to support more than 8G
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Guo Chao <yan@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 8, 2014 at 3:24 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Thu, Jul 03, 2014 at 01:46:17PM -0700, Yinghai Lu wrote:
>> Use 128G instead.
>>
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>
> I applied this one to pci/resource for v3.17, thanks!
>
> I didn't apply [2/3] or [3/3] because the questions I raised earlier
> haven't been resolved.

That is fine. We can apply [2/3] later if there is any regression ...
