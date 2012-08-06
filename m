Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34978 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756921Ab2HFX74 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 6 Aug 2012 19:59:56 -0400
Received: by lbbgm6 with SMTP id gm6so3142958lbb.19
        for <linux-pci@vger.kernel.org>; Mon, 06 Aug 2012 16:59:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <loom.20120807T010348-354@post.gmane.org>
References: <loom.20120807T001740-895@post.gmane.org> <20120806224658.GA8579@kroah.com>
 <loom.20120807T010348-354@post.gmane.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 6 Aug 2012 16:59:34 -0700
Message-ID: <CAErSpo5-U1AJr1+HbkGxXKKa8MQ0WOzSpVNy7ooj2rtPoXyHnQ@mail.gmail.com>
Subject: Re: accessing pci_dev
To: Paolo <paolopiace@gmail.com>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 6, 2012 at 4:16 PM, Paolo <paolopiace@gmail.com> wrote:
> Basically, I want to check the config registers before and after the driver
> registration in order to make sure that the driver is not contaminating them.

The user command "lspci -x" is a good way to see raw config space.

If you don't need the driver for boot, you can build it as a module,
make sure it isn't automatically loaded (e.g., rename it temporarily),
reboot, run lspci once, load the driver module by hand, and then run
lspci again.

If you're on x86, you can also boot with the kernel option
"pci=earlydump" to see config space before any drivers touch it, even
if they're built into the kernel.

Bjorn
