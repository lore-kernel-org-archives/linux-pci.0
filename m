Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from minas.ics.muni.cz ([147.251.4.40]:44322 "EHLO minas.ics.muni.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751668Ab2HAVvI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 1 Aug 2012 17:51:08 -0400
Date: Wed, 1 Aug 2012 23:50:54 +0200
From: Lukas Hejtmanek <xhejtman@ics.muni.cz>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Roland Dreier <roland@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: mellanox mlx4_core and SR-IOV
Message-ID: <20120801215054.GO5470@ics.muni.cz>
References: <20120801133835.GH5470@ics.muni.cz>
 <CAG4TOxONLJnBaY7N5x7Kfi+dwCb507QPqX9s_Wuef10+RzM=AQ@mail.gmail.com>
 <CAE9FiQUSFeBpGaFByOfENUa8qg7t89WTiUann8=4ezT7s2qmzw@mail.gmail.com>
 <20120801202840.GM5470@ics.muni.cz>
 <CAE9FiQWY+Z-_=th8ndh15A+AokDFpi2_dk5UiXyJaCj_KovMJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <CAE9FiQWY+Z-_=th8ndh15A+AokDFpi2_dk5UiXyJaCj_KovMJw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 01, 2012 at 02:27:34PM -0700, Yinghai Lu wrote:
> you may try to boot with pci=nocrs

ok, pci=nocrs i got:
02:00.0 InfiniBand: Mellanox Technologies MT26428 [ConnectX VPI PCIe 2.0 5GT/s - IB QDR / 10GigE] (rev b0)
02:00.1 InfiniBand: Mellanox Technologies MT25400 Family [ConnectX-2 Virtual Function] (rev b0)
02:00.2 InfiniBand: Mellanox Technologies MT25400 Family [ConnectX-2 Virtual Function] (rev b0)
02:00.3 InfiniBand: Mellanox Technologies MT25400 Family [ConnectX-2 Virtual Function] (rev b0)
02:00.4 InfiniBand: Mellanox Technologies MT25400 Family [ConnectX-2 Virtual Function] (rev b0)

so it works. Should I try your patch without pci=nocrs?

-- 
Luká¹ Hejtmánek
