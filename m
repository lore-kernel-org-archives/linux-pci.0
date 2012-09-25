Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:60127 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753641Ab2IYTix (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2012 15:38:53 -0400
Received: by bkcjk13 with SMTP id jk13so1477068bkc.19
        for <linux-pci@vger.kernel.org>; Tue, 25 Sep 2012 12:38:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
References: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
Date: Tue, 25 Sep 2012 12:38:52 -0700
Message-ID: <CAE9FiQVuRt2wN3Tecng6L-J--mQ1On5Z8J62TCO0h0iWe6Wnrw@mail.gmail.com>
Subject: Re: [PATCH 00/29] PCI: use pci host bridge to loop pci root bus
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 25, 2012 at 1:26 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> could remove pci_root_buses list.

updated brach: two typo fixing and two Acked-by.

git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
for-pci-kill-pci-root-buses

http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=shortlog;h=refs/heads/for-pci-kill-pci-root-buses
