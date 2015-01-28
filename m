Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:63265 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761740AbbA1Eo0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jan 2015 23:44:26 -0500
Received: by mail-ie0-f172.google.com with SMTP id rd18so19496713iec.3
        for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2015 20:44:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAErSpo6P-gm1xFjLrbKBU+P3zUHY-RGMkhaVpWsK7vDz_wK=YQ@mail.gmail.com>
References: <54C81B4E.7060900@nwtrail.com>
	<CAErSpo6P-gm1xFjLrbKBU+P3zUHY-RGMkhaVpWsK7vDz_wK=YQ@mail.gmail.com>
Date: Tue, 27 Jan 2015 20:44:25 -0800
Message-ID: <CAE9FiQVLxP5vKsrZ2T9-uGLrDYGHTG2QO9-52-C-XVQ227gLwA@mail.gmail.com>
Subject: Re: [problem] mpt2sas load fails with LSISAS2008
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: pjay@nwtrail.com, linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 27, 2015 at 8:02 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Would you mind opening a report at http://bugzilla.kernel.org and
> attaching the complete dmesg logs from both kernels to it?  If there
> was no working kernel, collect a log from v3.19-rc6 with
> "pci=realloc=off" instead.

would be better if with "debug ignore_loglevel pci=realloc=off".

Yinghai
