Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:54315 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534Ab3AUCm4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 20 Jan 2013 21:42:56 -0500
MIME-Version: 1.0
In-Reply-To: <14158003.3rfOuOmdG2@vostro.rjw.lan>
References: <1358495602-22867-1-git-send-email-yinghai@kernel.org>
	<1358495602-22867-10-git-send-email-yinghai@kernel.org>
	<14158003.3rfOuOmdG2@vostro.rjw.lan>
Date: Sun, 20 Jan 2013 18:42:55 -0800
Message-ID: <CAE9FiQUac48U0o4dr3ONdqeBvGsgHGRtOemTh+4FtKcGVbCG4w@mail.gmail.com>
Subject: Re: [PATCH v9 09/11] PCI, acpiphp: Don't bailout even no slots found yet.
From: Yinghai Lu <yinghai@kernel.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>
> If that's the case:
>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> but please say something like this in the changelog:
>
> "The result returned by acpiphp_get_num_slots() is meaningless, because
>  the bridge the slots are under may be added after this function has been
>  called, so drop acpiphp_get_num_slots() and the code using it."

yes, I add you inputs into change log.

Thanks a lot
