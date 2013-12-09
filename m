Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:40885 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761411Ab3LIUVT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Dec 2013 15:21:19 -0500
Received: by mail-ie0-f175.google.com with SMTP id x13so7004346ief.20
        for <linux-pci@vger.kernel.org>; Mon, 09 Dec 2013 12:21:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQXf6w0u+JLu-JHd45ofSTShaB0MoMNbck9EE-y3u6B98w@mail.gmail.com>
References: <1386546869-31900-1-git-send-email-yinghai@kernel.org>
 <1386546869-31900-3-git-send-email-yinghai@kernel.org> <CAErSpo6VvV21DyHuHLcsA+_KPQcYdAWXtaVbZGUA-M9+iji0fw@mail.gmail.com>
 <CAE9FiQUWFoyg_7TPaBVftpojCocNu0=1yWtqKTBvkQkRhNOnhg@mail.gmail.com>
 <CAErSpo5+jY-P-9iUj0RVqyZzXwQcq9m9PqWKzZDU0yjK=4gAeQ@mail.gmail.com> <CAE9FiQXf6w0u+JLu-JHd45ofSTShaB0MoMNbck9EE-y3u6B98w@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 9 Dec 2013 13:20:59 -0700
Message-ID: <CAErSpo6xSYq=7AfFm+qNLGSfe6qjaGKyrwxdpG_CXHSy2uVX_w@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: Only enable realloc auto when root bus has 64bit mmio
To: Yinghai Lu <yinghai@kernel.org>
Cc: Joseph Salisbury <joseph.salisbury@canonical.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 9, 2013 at 1:10 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Mon, Dec 9, 2013 at 11:42 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> That doesn't answer my question at all.
>>
>> I understand that this change makes it so Joseph doesn't have to use
>> "pci=realloc=off".  But why should auto-reallocation be limited to
>> buses that have resources above 4GB?  That doesn't make any sense.
>>
>> We should fix the reallocation code so it can deal with this case.  If
>> there's not enough space for everything, obviously we have to leave
>> something unassigned.  A ROM BAR is a good candidate for leaving
>> unassigned, because most of the time we can get along without it.
>
> Yes, that is ideal and not that simple.
> but that would be hard to backport to old kernels.

Yes, I agree.  I didn't say it would be simple.  The quick fix would
be easy for now, but adding nonsensical code makes our lives harder
long into the future.

Bjorn
