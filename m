Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:45243 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421AbaHKRB2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Aug 2014 13:01:28 -0400
Received: by mail-qg0-f49.google.com with SMTP id j107so8553868qga.8
        for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2014 10:01:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <53D9FADA.6020304@iam.tj>
References: <53D9FADA.6020304@iam.tj>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 11 Aug 2014 11:01:08 -0600
Message-ID: <CAErSpo4J6nNzhT6e7xf85+J_dDCht3V35HLAmc+zCPiA48MUMw@mail.gmail.com>
Subject: Re: Regression: pci=realloc fails to modify bridge windows, causing
 devices to fail BAR allocation
To: TJ <linux@iam.tj>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci]

On Thu, Jul 31, 2014 at 2:14 AM, TJ <linux@iam.tj> wrote:
> See https://bugzilla.kernel.org/show_bug.cgi?id=81431
>
> Summary:
>
> Up until v3.15.7 booting with "pci=realloc,use_crs" successfully modifies
> the PCI bridge windows to allow an external ExpressCard <> ViDock4 + Nvidia
> Quadro NVS420 with its 2 GPUs to be configured.
>
> With v3.16rc6 and rc7 it fails to do this, leaving the NVS420 inoperable.

Thanks for the report and the dmesg logs.  I'm just returning from
vacation and haven't been able to analyze them yet.  If you have a
chance to bisect this to a specific commit, we might be able to fix or
revert it.

Bjorn
