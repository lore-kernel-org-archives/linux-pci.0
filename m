Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:33188 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759AbbIOO6S (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2015 10:58:18 -0400
Received: by wiclk2 with SMTP id lk2so32915986wic.0
        for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2015 07:58:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQXr3vqusta0Tb35BovbWh7jDZ5uVQer741ioWKhYr7xmA@mail.gmail.com>
References: <1440138067-4314-1-git-send-email-yinghai@kernel.org>
 <1440138067-4314-5-git-send-email-yinghai@kernel.org> <20150914202123.GA27964@google.com>
 <CAE9FiQXr3vqusta0Tb35BovbWh7jDZ5uVQer741ioWKhYr7xmA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 15 Sep 2015 09:57:57 -0500
Message-ID: <CAErSpo5VAb_YRpz7PEzuZ9AthAQ67quMKE3Y0dfMHVKjw0OTxA@mail.gmail.com>
Subject: Re: [PATCH v4 04/52] PCI: Optimize bus min_align/size calculation
 during sizing
To: Yinghai Lu <yinghai@kernel.org>
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

On Mon, Sep 14, 2015 at 4:37 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Mon, Sep 14, 2015 at 1:21 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> I spent a couple hours trying to understand the v3 version of this
>> patch, and I gave you some detailed examples and questions.  If you
>> want me to look at v4, I expect you to try to clarify the changelog to
>> help answer those questions.
>
> you example is  addressed in following patch that support alt_size

My fundamental question about this changelog was "I want to understand
what makes 256M/768M 'optimal.'"  That needs to be addressed in the
changelog for *this* patch, and this changelog is essentially
unchanged from v3.

>> The goal is that someone with reasonable familiarity with Linux and
>> PCI would be able to read the changelogs and understand what happened,
>> without having to search out all the email discussions.
>
> Agreed. But changelog for this should not talk alt_size support in
> following patch.

Maybe you split the patches in a way that makes this changelog not
match this patch.  I don't know, and I don't really have time to
figure it all out myself.

> Also please let me know if you prefer to reviewing v5 that would be
> re-based on v4.3-rc1
> instead of v4. or I could wait to post v5 after you finish v4.

Any future series you post should be based on the most recent -rc1 at
the time.  I apply patches to branches based on -rc1 unless they
actually depend on something merged after -rc1.

We are not communicating effectively, so I'm going to dispose of some
of the other pending patches before returning to this series.  If
there are simple patches with good changelogs early in the series, I
can apply those incrementally.  But this patch is [04/52] and is a
sticking point, so that strategy doesn't get me very far.

Bjorn
