Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:64709 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945950Ab3FUUTu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jun 2013 16:19:50 -0400
Received: by mail-ob0-f173.google.com with SMTP id wc20so8785110obb.4
        for <linux-pci@vger.kernel.org>; Fri, 21 Jun 2013 13:19:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAH9N0t_gPz_MBiBSbLpATD3j-+LgS=7jqNbtv3qqg6v8K76dzg@mail.gmail.com>
References: <CAH9N0t_qrzLqeR6tZ8ykbFEzx0dZtCREjz9wCwCDTDDFwic6-Q@mail.gmail.com>
	<CAE9FiQWJV=NPn9yBX2nQ9z8hFc4_9tNHm5BWwsY4dG_h7yYmvA@mail.gmail.com>
	<CAH9N0t_gPz_MBiBSbLpATD3j-+LgS=7jqNbtv3qqg6v8K76dzg@mail.gmail.com>
Date: Fri, 21 Jun 2013 13:19:49 -0700
Message-ID: <CAE9FiQWXKJvhmmPHWX+v7EZdTkNWZAWgTtjibgsBVhWRYadoWg@mail.gmail.com>
Subject: Re: PCIe Hotplug Script Automatization.
From: Yinghai Lu <yinghai@kernel.org>
To: Paulo Fortuna Carvalho <pricardofc@ipfn.ist.utl.pt>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 21, 2013 at 1:02 PM, Paulo Fortuna Carvalho
<pricardofc@ipfn.ist.utl.pt> wrote:
> Kernel version is 3.0.9-rt26.46.el6rt.x86_64.
> Also at the moment im not loading acpiphp.ko module.

can you post boot log with "debug ignore_loglevel"?

Yinghai
