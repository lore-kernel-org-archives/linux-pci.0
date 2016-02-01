Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33733 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757654AbcBAEOy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 31 Jan 2016 23:14:54 -0500
Message-ID: <1454300093.10542.3.camel@redhat.com>
Subject: Re: Q: Relation between lanes to devices and to BARs
From: Alex Williamson <alex.williamson@redhat.com>
To: Ran Shalit <ranshalit@gmail.com>, linux-pci@vger.kernel.org
Date: Sun, 31 Jan 2016 21:14:53 -0700
In-Reply-To: <CAJ2oMhL-oL68ZOLsFEn3uGE=O9sMjcwPDH6oznLhG15xnzSQtQ@mail.gmail.com>
References: <CAJ2oMhL-oL68ZOLsFEn3uGE=O9sMjcwPDH6oznLhG15xnzSQtQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 2016-01-31 at 02:15 -0500, Ran Shalit wrote:
> Hello,
> 
> I am new to pci express drivers, and would please like to ask a question.
> We develop a linux driver for a PCIe device board with 4 lanes.
> 1. Is it expected that this will be recognized as a single device or
> multiple device ?

It depends whether your device is multifunction.

> 2. Is it that each lane rales to a different BAR or there is no
> connection between these two ?

No relation, all PCI/e devices have the same set of standard BARs
available to them.

