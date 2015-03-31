Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:37919 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415AbbCaSZ6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 31 Mar 2015 14:25:58 -0400
MIME-Version: 1.0
In-Reply-To: <20150331.141911.1147249607585406404.davem@davemloft.net>
References: <CAE9FiQUVSRkKNRzh99JA7V8dqsY78z_GtnMnwTrpSFXkJV9CKA@mail.gmail.com>
	<20150331.110636.1386273674508393491.davem@davemloft.net>
	<CAE9FiQUbKu-UWRBMJwn-fTH+LnEpODnOW+kGHg1FCtTZ3oDepQ@mail.gmail.com>
	<20150331.141911.1147249607585406404.davem@davemloft.net>
Date: Tue, 31 Mar 2015 11:25:57 -0700
Message-ID: <CAE9FiQXgR+k5zv9W4EbO7of=Rxzt3p=NFop+UzAUT6s9c9EBmw@mail.gmail.com>
Subject: Re: d63e2e1f3df breaks sparc/T5-8
From: Yinghai Lu <yinghai@kernel.org>
To: David Miller <davem@davemloft.net>
Cc: David Ahern <david.ahern@oracle.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 31, 2015 at 11:19 AM, David Miller <davem@davemloft.net> wrote:

> I totally disagree, I think your test is too stringent and should be
> significantly relaxed if not removed entirely.

ok, will produce one version that only verify first criteria.

Thanks

Yinghai
