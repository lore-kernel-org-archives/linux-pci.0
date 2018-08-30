Return-Path: <SRS0=xLx8=LN=gmail.com=alexander.duyck@kernel.org>
Return-Path: <SRS0=xLx8=LN=gmail.com=alexander.duyck@kernel.org>
MIME-Version: 1.0
References: <CAKgT0Uf64TJrK7sEzj-vHb-7kci_-RtcM_ykTw-0gPgd53_9Pw@mail.gmail.com>
 <2d84340e-0703-0bc7-4917-3b18979b2aa5@mellanox.com> <b8b1444f-ee31-b6c1-a5e2-aa0d2e08d2e5@mellanox.com>
 <CAKgT0UdT5yPESZd2U=K-n47pDpAjH4Ed08KKrK-Hf9F=N1hm_Q@mail.gmail.com> <5206dd74-432d-3342-2a48-3cdd1be8b5cb@mellanox.com>
In-Reply-To: <5206dd74-432d-3342-2a48-3cdd1be8b5cb@mellanox.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 30 Aug 2018 08:39:56 -0700
Message-ID: <CAKgT0UfyFqEyYibVAJzeuNcCy4LDepxm3n_qdfyPBbmvvEZFVw@mail.gmail.com>
Subject: Re: [pull request][net-next 00/10] Mellanox, mlx5 and devlink updates 2018-07-31
To: valex@mellanox.com
Cc: Erez Shitrit <erezsh@mellanox.com>, Saeed Mahameed <saeedm@dev.mellanox.co.il>,
	Saeed Mahameed <saeedm@mellanox.com>, David Miller <davem@davemloft.net>,
	Netdev <netdev@vger.kernel.org>, Jiri Pirko <jiri@mellanox.com>,
	Jakub Kicinski <jakub.kicinski@netronome.com>, Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

I'm dropping all the old comments since the conversation was flattened
and only has one level of marks for everything.

On Thu, Aug 30, 2018 at 7:43 AM Alex Vesker <valex@mellanox.com> wrote:

<snip>

> To which devlink interfaces are you referring?

All of them. Not just the ones in this patch. If you are exposing an
interface to the user you should have documentation for it somewhere.
You should probably look at adding a patch to make certain you have
all the existing devlink interfaces in the driver documented.

I would like to see something added to the documentation folder that
explains what all the DEVLINK_PARAM_GENERIC interfaces are expected to
do, and maybe why I would use them. Then in addition I would like to
see per-driver documentation added for the DEVLINK_PARAM_DRIVER calls.
So for example I can't find any documentation in the kernel on what
enable_64b_cqe_eqe or enable_4k_uar do in mlx4 or why I would need
them, but you have them exposed as interfaces to userspace.

> There are 3 patches here that provide the crdump capability,
> these are the patches I would like to resubmit.
>
> net/mlx5: Add Vendor Specific Capability access gateway:
>     This is needed to read from the VSC by only the driver to collect a dump

You should probably work with the linux-pci mailing list on this bit
since you are exposing a new capability and they can probably point
you in the direction of how they want to deal with any potential races
in terms of access to the device versus your capability which you are
adding support for dumping via devlink.

> net/mlx5: Add Crdump FW snapshot support
>     This is code that collects the dump and registers a region called crdump
> net/mlx5: Use devlink region_snapshot parameter
>     Here I use an already implemented global param that specifies whether
>     snapshots are supported.
>
> The devlink region feature is well documented.

Where?

> can it be that you referring to devlink region called "crdump" which mlx5 exposes?

I don't care about the internals. I care about user available
documentation for the interface that is exposed. How do you expect the
user to use this functionality? That is what I want documented.

<snip>

> Will it be sufficient to prevent setcpi access using "pci_cfg_access_lock -
> any userspace reads or writes to config space and concurrent lock requests will sleep"
> otherwise do you have a different solution?

That sounds like a step in the right direction, but that is something
you should work with the linux-pci list on. My main concern is that I
don't want us being able to come at this interface from multiple
directions and screw things up.
