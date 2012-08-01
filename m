Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 2 Aug 2012 00:08:02 +0200
From: Lukas Hejtmanek <xhejtman@ics.muni.cz>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Roland Dreier <roland@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: mellanox mlx4_core and SR-IOV
Message-ID: <20120801220802.GP5470@ics.muni.cz>
References: <20120801133835.GH5470@ics.muni.cz>
 <CAG4TOxONLJnBaY7N5x7Kfi+dwCb507QPqX9s_Wuef10+RzM=AQ@mail.gmail.com>
 <CAE9FiQUSFeBpGaFByOfENUa8qg7t89WTiUann8=4ezT7s2qmzw@mail.gmail.com>
 <20120801205640.GN5470@ics.muni.cz>
 <CAE9FiQWmgyirjjCwn54PkAsfvWxZSY5RhRVDkhhbK7E0NPzqaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <CAE9FiQWmgyirjjCwn54PkAsfvWxZSY5RhRVDkhhbK7E0NPzqaw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 01, 2012 at 02:32:17PM -0700, Yinghai Lu wrote:
> yes, i knew that.
> 
> one patch in my for-pci-next should address that.
> 
> http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=patch;h=fcce563f868e296f46a2eeaa88d6959bcee26a2d

this is probably only half-way. well mlx driver loads but it complains again
on MMIO:
[    3.564844] mlx4_core: Mellanox ConnectX core driver v1.1 (Dec, 2011)
[    3.564845] mlx4_core: Initializing 0000:02:00.0
[    3.564967] mlx4_core 0000:02:00.0: Enabling sriov with:4 vfs
[    3.565087] mlx4_core 0000:02:00.0: not enough MMIO resources for SR-IOV
[    3.565402] mlx4_core 0000:02:00.0: Failed to enable sriov,continuing
without sriov enabled (err = -12).

so it seems, that pic=nocsr is a must now.

-- 
Luká¹ Hejtmánek
