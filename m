Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from edison.jonmasters.org ([173.255.233.168]:37478 "EHLO
        edison.jonmasters.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759484AbdDSFAR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Apr 2017 01:00:17 -0400
To: abhijit <abhijitnaik27@gmail.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <50712b3b-2943-0b78-9413-257f33b26c3f@gmail.com>
From: Jon Masters <jcm@jonmasters.org>
Message-ID: <99dce715-e83a-72ce-aa01-f388b73c2604@jonmasters.org>
Date: Wed, 19 Apr 2017 01:00:15 -0400
MIME-Version: 1.0
In-Reply-To: <50712b3b-2943-0b78-9413-257f33b26c3f@gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: Doubt on first access for PCIe device
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/11/2017 10:15 AM, abhijit wrote:

> Here I am assuming, the completer ID will be device number and function 
> number that will eventually programmed in to  device. In that case, my 
> question is, without first write, how read request(VENDOR ID read) is 
> serviced/routed?

You'll want to read about PCIe enumeration at boot time and how the BIOS
walks the topology to assign these (which an OS may later re-number). In
particular, read about ECAM for configuration. This uses memory mapped
config space read/write accessors that target a memory address space
under the control of the root complex.

Jon.
