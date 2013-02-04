Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 4 Feb 2013 10:33:15 +1000
Message-ID: <CAPM=9tyyR2YkaFPHQGy_mU9YM87uaQ79Cgxvy=-ZfAAuxcSj+g@mail.gmail.com>
Subject: pci_lock and runtime resume
From: Dave Airlie <airlied@gmail.com>
To: linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

So I've just been looking a bit more at dynamic PM for graphics and
noticed that when userspace reads pci config space, the read happens
under the pci_lock which is a spinlock.
Now on most of the GPU drivers we'll be entering standard s/r paths
which don't have this restriction from what I can see, I get to see
lots of scheduling while atomic fun, that I'm not really sure I can
fix nicely.

Dave.
