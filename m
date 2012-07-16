Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:44756 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888Ab2GPQFh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Jul 2012 12:05:37 -0400
Received: by lbbgm6 with SMTP id gm6so8875063lbb.19
        for <linux-pci@vger.kernel.org>; Mon, 16 Jul 2012 09:05:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo6Xdc-rDvvipJFzXbbF3V75zSBq4skMtZ2PDVsz1kxtdw@mail.gmail.com>
References: <1340437325-29282-1-git-send-email-yinghai@kernel.org>
 <1340437325-29282-5-git-send-email-yinghai@kernel.org> <CAErSpo7SS1N+h+VyGoCBq5HCMezvFAonRZR-pqsYezVHX2-_2w@mail.gmail.com>
 <20120711171458.GA14610@redhat.com> <CAErSpo6Xdc-rDvvipJFzXbbF3V75zSBq4skMtZ2PDVsz1kxtdw@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 16 Jul 2012 10:05:16 -0600
Message-ID: <CAErSpo7_07Kun3re6qxV-Pz9cONzauhRN_GpUQattTp1vUk5+w@mail.gmail.com>
Subject: Re: [PATCH 4/5] PCI, acpiphp: add is_hotplug_bridge detection
To: Jason Baron <jbaron@redhat.com>
Cc: Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 11, 2012 at 1:42 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Wed, Jul 11, 2012 at 11:14 AM, Jason Baron <jbaron@redhat.com> wrote:

>> Using the same code base I was able to do acpi hotplug on Windows 7,
>> which correctly configured the both the bridge window and devices behind
>> it on hot-plug. So currently, the above usage pattern works on Windows
>> 7, but not on Linux.
>
> Thanks, Jason.  Do you have "lspci -v" output and the DSDT AML handy?
> I'd like to look in more detail at what we're missing.

Ping?
