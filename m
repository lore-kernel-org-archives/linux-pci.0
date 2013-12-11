Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:51221 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466Ab3LKT6Z (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Dec 2013 14:58:25 -0500
MIME-Version: 1.0
In-Reply-To: <CAErSpo4dV_BWj1PFxzmeweg++iA7V8z56P5ZO=vArK4kB_ve4Q@mail.gmail.com>
References: <1385429290-25397-1-git-send-email-yinghai@kernel.org>
	<1385429290-25397-11-git-send-email-yinghai@kernel.org>
	<CAErSpo4Sa6hpv45E9fQB_LsSrTt_mFzxbJvRocuCo9HXcAYfow@mail.gmail.com>
	<CAE9FiQWcUqK11PSD-fCnD_G8HzvTh08N8h5tvQe2Z_YdZa7POQ@mail.gmail.com>
	<CAErSpo4dV_BWj1PFxzmeweg++iA7V8z56P5ZO=vArK4kB_ve4Q@mail.gmail.com>
Date: Wed, 11 Dec 2013 11:58:25 -0800
Message-ID: <CAE9FiQW8ZwELZwGooUAwkEv86fHWu0t7+mHo8ZoS9EsV5XZE+Q@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] intel-gtt: Read 64bit for gmar_bus_addr
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Airlie <airlied@linux.ie>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Gu Zheng <guz.fnst@cn.fujitsu.com>,
	Guo Chao <yan@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 11, 2013 at 10:48 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
> Doesn't that mean that this series should be reordered so this patch
> is *before* patches 5-9 to avoid bisection breakage?  I know you've
> split up and reposted parts of the series, but the question still
> applies.

Yes, you are right.

Maybe we have this one go through via Dave Airlie at first for 3.13?

Thanks

Yinghai
