Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ms.lwn.net ([45.79.88.28]:38254 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751654AbcLHOFm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Dec 2016 09:05:42 -0500
Date: Thu, 8 Dec 2016 07:05:39 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linasvepstas@gmail.com>,
        <bhelgaas@google.com>
Subject: Re: [PATCH] pci-error-recover: doc cleanup
Message-ID: <20161208070539.0f00ce71@lwn.net>
In-Reply-To: <1481184974-12505-1-git-send-email-caoj.fnst@cn.fujitsu.com>
References: <1481184974-12505-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 8 Dec 2016 16:16:14 +0800
Cao jin <caoj.fnst@cn.fujitsu.com> wrote:

>  The platform resets the link, and then calls the link_reset() callback
>  on all affected device drivers.  This is a PCI-Express specific state
> -and is done whenever a non-fatal error has been detected that can be
> +and is done whenever a fatal error has been detected that can be
>  "solved" by resetting the link. This call informs the driver of the

As far as I can tell, the original text was correct here; why do you
think this change needs to be made?

Thanks,

jon
