Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:48640 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932200Ab2ARR1j convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2012 12:27:39 -0500
Received: by ghbg16 with SMTP id g16so3076725ghb.19
        for <linux-pci@vger.kernel.org>; Wed, 18 Jan 2012 09:27:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAErSpo7xgJmT=gs8axiY-OseyurqwUEqYixm692kmZAoA-2sNw@mail.gmail.com>
References: <20120118003335.467.71863.stgit@bhelgaas.mtv.corp.google.com>
	<20120118003512.467.60770.stgit@bhelgaas.mtv.corp.google.com>
	<CAE9FiQXvLAJVY-t8EJHkJgugtRsPdT9SS=60vA+by6qMCd5-Wg@mail.gmail.com>
	<CAErSpo7xgJmT=gs8axiY-OseyurqwUEqYixm692kmZAoA-2sNw@mail.gmail.com>
Date: Wed, 18 Jan 2012 09:27:38 -0800
Message-ID: <CAE9FiQUMEv+=mXzGc_muM_zTQ14S8tVex+bYgyyM1F++37Cu8w@mail.gmail.com>
Subject: Re: [PATCH 3/4] PCI: restrict subordinate buses to those reachable
 via host bridge
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 18, 2012 at 8:52 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> If we make a quirk for this machine, we still have the question of
> what to do with my patches.  I assert that if Linux ever reconfigures
> any bus numbers or does any configuration of hot-added P2P bridges, it
> must pay attention to the host bridge bus number window.  Therefore, I
> think we need something like this series even if we make a quirk.

We may need more smart way to find unused bus range instead of just
just max+1 and ++max.

For example:  one bridge (A) have two child bridges (B and C),
A: bus range: 10-2f
B: bus range: 11-1f
C: bus range: 20-2f

when some broken case happen, B bus BIOS assigned bus range will be
all cleared in first pass.
but C bus is ok.  but in second bus, bus will be assigned to 30- .
that is totally wrong, We should still
try to use bus 11-1f at first for bus B.

your patches should be ok, only exception should be considered: some
default link root bus could access
out of bus range state with _CRS stating.  some kind of transparent
bridge concept.

Thanks

Yinghai
