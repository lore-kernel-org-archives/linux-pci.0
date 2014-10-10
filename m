Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:45035 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077AbaJJOVX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Oct 2014 10:21:23 -0400
Received: by mail-ig0-f179.google.com with SMTP id h18so2843509igc.12
        for <linux-pci@vger.kernel.org>; Fri, 10 Oct 2014 07:21:23 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 10 Oct 2014 09:21:23 -0500
Message-ID: <CAA8O7Cqry5=n0SLNB2+cfhQDMch2ujkCwJ95nfEtDjJ4gn2ndA@mail.gmail.com>
Subject: designware: Safety of sharing iATU entries between cfg0 & mem, cfg1 & I/O?
From: L H <swdevgid@gmail.com>
To: jg1.han@samsung.com, amurray@embedded-bits.co.uk
Cc: linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Can someone please explain how the sharing of iATUs between cfg0 and
mem accesses, and cfg1 and I/O accesses can operate safely with
concurrent operations?

I read in dw_pcie_[rd|wr]_other_conf() that the code invokes the
dw_pcie_prog_viewport_XXXX() functions to reprogram the iATU entries.
Both cfg0 and memory regions are mapped alternately by
PCIE_ATU_REGION_INDEX0, and both cfg1 and I/O regions are mapped
alternately by PCIE_ATU_REGION_INDEX1.  I noted in the git log that a
previously coded lock was deemed unnecessary and removed around config
operations, but I haven't identified any logic that protects the
possibility of a driver say performing a memory operation while
another is issuing a config.  It would seem to me that there's a small
window of opportunity that the driver performing a memory operation
could have its iATU entry pulled out from underneath it if
concurrently another driver was performing a config operation.

Is there something higher up the call stack, or scheduling-wise, that
prevents this from occurring?

thanks,
LH
