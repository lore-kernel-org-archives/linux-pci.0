Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50484 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090Ab2DVS4u (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 22 Apr 2012 14:56:50 -0400
Received: by pbcun15 with SMTP id un15so3033679pbc.19
        for <linux-pci@vger.kernel.org>; Sun, 22 Apr 2012 11:56:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1335108346.25945.1.camel@oc4748611672.ibm.com>
References: <1335108346.25945.1.camel@oc4748611672.ibm.com>
Date: Sun, 22 Apr 2012 11:56:49 -0700
Message-ID: <CAE9FiQVKAGAvUtSz-mSNHXmP+d3LQ2YaiH0ygyAtad4TMoc_BA@mail.gmail.com>
Subject: Re: What possible values can pci_root_num take ??
From: Yinghai Lu <yinghai@kernel.org>
To: Onkar N Mahajan <kernzap@gmail.com>
Cc: linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Apr 22, 2012 at 8:25 AM, Onkar N Mahajan <kernzap@gmail.com> wrote:
> What are the possible values that can be taken
> by pci_root_num ?? Where can I find this information ( any specs docs ?)
>

from amd Hypertransport  (HT) chain number: 4 at most at that time.

arch/x86/pci/bus_numa.h::

/* 4 at this time, it may become to 32 */
#define PCI_ROOT_NR 4
extern int pci_root_num;
extern struct pci_root_info pci_root_info[PCI_ROOT_NR];
