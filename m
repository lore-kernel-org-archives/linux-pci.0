Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51871 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932330AbbLQVzU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 17 Dec 2015 16:55:20 -0500
Date: Thu, 17 Dec 2015 15:55:17 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bogicevic Sasa <brutallesale@gmail.com>
Cc: bhelgaas@google.com, lenb@kernel.org, scott@spiteful.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] drivers:pci:hotplug Fix all whitespace issues
Message-ID: <20151217215517.GA4864@localhost>
References: <1449849824-100004-1-git-send-email-brutallesale@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1449849824-100004-1-git-send-email-brutallesale@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bogicevic,

On Fri, Dec 11, 2015 at 08:03:44AM -0800, Bogicevic Sasa wrote:
> This fixes all sorts of whitespace errors and warnings as
> well as blank line required after declaration messages in
> drivers/pci/hotplug folder

1) Can you combine drivers/pci/hotplug with drivers/pci in a single
patch?

2) Can you run objdiff on an allyesconfig build to make sure nothing
really changed, and mention this in the changelog as you did with one
of your others?  This might require moving the blank line
additions/removals to a separate patch because those might change
debug info or line numbers in printk messages.

Bjorn
