Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1448566598.18647.12.camel@perches.com>
Subject: Re: [PATCH] drivers:pci:hotplug Fix space prohibited between
 function name and open parenthesis '('
From: Joe Perches <joe@perches.com>
To: Bogicevic Sasa <brutallesale@gmail.com>, bhelgaas@google.com
Cc: lenb@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Thu, 26 Nov 2015 11:36:38 -0800
In-Reply-To: <1448553041-18601-1-git-send-email-brutallesale@gmail.com>
References: <1448553041-18601-1-git-send-email-brutallesale@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2015-11-26 at 16:50 +0100, Bogicevic Sasa wrote:
> This fixes all errors "space prohibited between function name and
> open parenthesis '(' " in all files in drivers/pci/hotplug folder

It's good when sending this sort of patch to add a bit of
description like "git diff -w shows no differences" and that
using scripts/objdiff also shows no difference.

Doing so shows that you've done a bit more than a mechanical
transformation using something like:

$ ./scripts/checkpatch -f --types=spacing --fix-inplace <files>

and that you have verified your changes too.

