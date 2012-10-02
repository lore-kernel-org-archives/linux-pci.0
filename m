Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61106 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754759Ab2JBUd6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Oct 2012 16:33:58 -0400
Received: by bkcjk13 with SMTP id jk13so5740962bkc.19
        for <linux-pci@vger.kernel.org>; Tue, 02 Oct 2012 13:33:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <506B4D4C.3080101@redhat.com>
References: <1349134020-62152-1-git-send-email-ddutile@redhat.com>
	<CAE9FiQUd=sM3XaMKfJjnJq6mkugL7P=wEjdcMHtGjfe4ooRXUQ@mail.gmail.com>
	<506B4D4C.3080101@redhat.com>
Date: Tue, 2 Oct 2012 13:33:55 -0700
Message-ID: <CAE9FiQVg6-JAo4fJL52bMo74Sc1DPY3nF_jXw6in1SG7A7HFXw@mail.gmail.com>
Subject: Re: [RFC] PCI: enable and disable sriov support via sysfs at per
 device level
From: Yinghai Lu <yinghai@kernel.org>
To: Don Dutile <ddutile@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, bhelgaas@google.com,
	yuvalmin@broadcom.com, bhutchings@solarflare.com,
	gregory.v.rose@intel.com, davem@davemloft.net
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 2, 2012 at 1:23 PM, Don Dutile <ddutile@redhat.com> wrote:

>
> Yinghai: As for looking at your patches, I did that.... and
> they made no sense, i.e., I don't see the value/use/need of
> 'is_visible'.

sysfs frame work use it during create sysfs files for that group.

> maybe if there was some decent
> documentation/comments on this stuff, I could
> confidently use them.... if they exist, please point me
> in the that direction.  if not, then point me to better examples.
> Looking in Documentation,

sriov_xxx.patch should create one file, you could just expand them to
make three.

Yinghai
