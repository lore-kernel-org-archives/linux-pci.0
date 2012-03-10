Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:52704 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987Ab2CJVUM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 10 Mar 2012 16:20:12 -0500
MIME-Version: 1.0
In-Reply-To: <20090320205656.12275.64680.stgit@bob.kio>
References: <20090320204327.12275.43010.stgit@bob.kio>
	<20090320205656.12275.64680.stgit@bob.kio>
Date: Sat, 10 Mar 2012 13:20:10 -0800
Message-ID: <CAE9FiQXsJJWQPRaya2ReWHtgvBTXYAa6SJ+SSm-gh2-_0cbYRg@mail.gmail.com>
Subject: Re: [PATCH v5 13/13] PCI Hotplug: schedule fakephp for feature removal
From: Yinghai Lu <yinghai@kernel.org>
To: Alex Chiang <achiang@canonical.com>
Cc: jbarnes@virtuousgeek.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 20, 2009 at 1:56 PM, Alex Chiang <achiang@hp.com> wrote:
> Now that the PCI core is capable of function-level remove and rescan
> as well as bus-level rescan, there's no functional need to keep fakephp
> anymore.
>
> We keep it around for userspace compatibility reasons, schedule removal
> in three years.
...
> +
> +What:  fakephp and associated sysfs files in /sys/bus/pci/slots/
> +When:  2011

Hi, Alex,

So it passed three years!

Can you please submit patch to remove fakephp ?

Thanks

Yinghai Lu
