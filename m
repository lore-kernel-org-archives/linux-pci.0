Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:48877 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758014Ab2C1Ute convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 28 Mar 2012 16:49:34 -0400
Received: by lahj13 with SMTP id j13so1622908lah.19
        for <linux-pci@vger.kernel.org>; Wed, 28 Mar 2012 13:49:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <jkvsjr$a3$1@dough.gmane.org>
References: <jkvsjr$a3$1@dough.gmane.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 28 Mar 2012 14:49:12 -0600
Message-ID: <CAErSpo68=vx=bv1OqFrR4Mn39wKM9bwdY=9o1TM0_GYC70Ty-g@mail.gmail.com>
Subject: Re: Kernel 3.3 boot panic (with screenshot) - ACPI related?
To: =?ISO-8859-1?Q?D=E2niel_Fraga?= <fragabr@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	Matthew Garrett <mjg@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 28, 2012 at 2:34 PM, Dâniel Fraga <fragabr@gmail.com> wrote:
>        Could you take a look at this bug report?
>
> https://bugzilla.kernel.org/show_bug.cgi?id=43003
>
>        I attached the screenshot. Thanks.

Might be the same as this report:
http://www.spinics.net/lists/linux-pci/msg14497.html

Matthew, the screenshot in bugzilla has a partial backtrace, but I
doubt it's enough to be useful.
