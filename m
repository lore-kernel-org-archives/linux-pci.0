Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from minas.ics.muni.cz ([147.251.4.40]:49876 "EHLO minas.ics.muni.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753554Ab2HAU4v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 1 Aug 2012 16:56:51 -0400
Date: Wed, 1 Aug 2012 22:56:40 +0200
From: Lukas Hejtmanek <xhejtman@ics.muni.cz>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Roland Dreier <roland@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: mellanox mlx4_core and SR-IOV
Message-ID: <20120801205640.GN5470@ics.muni.cz>
References: <20120801133835.GH5470@ics.muni.cz>
 <CAG4TOxONLJnBaY7N5x7Kfi+dwCb507QPqX9s_Wuef10+RzM=AQ@mail.gmail.com>
 <CAE9FiQUSFeBpGaFByOfENUa8qg7t89WTiUann8=4ezT7s2qmzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <CAE9FiQUSFeBpGaFByOfENUa8qg7t89WTiUann8=4ezT7s2qmzw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 01, 2012 at 11:29:02AM -0700, Yinghai Lu wrote:
> iov bar is not assigned by BIOS, and kernel can not find range for it too.
> 
> Lukas, can you post whole boot log with PCI_DEBUG enabled? That will
> tell exact why kernel does not assign them.
> 
> Recent kernel from 3.4... should enable realloc when SRIOV bar is not assigned.

sorry for confusing, PCI_DEBUG does not break mlx driver, it is reallocation
code that results:
[    3.555008] mlx4_core 0000:02:00.0: Missing UAR, aborting.

-- 
Luká¹ Hejtmánek
