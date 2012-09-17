Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:48522 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932584Ab2IQX4d (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 17 Sep 2012 19:56:33 -0400
MIME-Version: 1.0
In-Reply-To: <CAErSpo7czA3C_yQcX_ntCMGEYLUHdbJysNFwTWY=QZ=bD9OpmA@mail.gmail.com>
References: <1346622458-30595-2-git-send-email-yinghai@kernel.org>
	<1346942071-15188-1-git-send-email-prarit@redhat.com>
	<CAE9FiQUwFbeRG9Rqj0HC-Nu-HPwe0GJt22HSnaTHu5A0FV7-9Q@mail.gmail.com>
	<CAErSpo5bg2miZ4qwLiXewDuURX5NhD5wNmPdfpKTtGF0z9OuzA@mail.gmail.com>
	<CAE9FiQXW4GcKwt0d2S1qGLCQk86X0j7_xSTrGD7Sy5h3-rUWHw@mail.gmail.com>
	<CAErSpo7czA3C_yQcX_ntCMGEYLUHdbJysNFwTWY=QZ=bD9OpmA@mail.gmail.com>
Date: Mon, 17 Sep 2012 16:56:31 -0700
Message-ID: <CAE9FiQW5QsoJbCSxJsEJu+jWxgMiY8TYsxZxhozq6M3h2vWpzw@mail.gmail.com>
Subject: Re: [PATCH part1 1/4] PCI, pciehp: Turn on link again after power off
 the slot
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Prarit Bhargava <prarit@redhat.com>, linux-pci@vger.kernel.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	stable@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 17, 2012 at 4:52 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
> This patch is just black magic then.  I don't want to intentionally
> treat a slot that's empty at boot differently than one that is empty
> after a hot-remove.

sure. Please drop this one.

Thanks

Yinghai
