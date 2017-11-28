Return-Path: <SRS0=8xXJ=C2=oracle.com=boris.ostrovsky@kernel.org>
Return-Path: <SRS0=8xXJ=C2=oracle.com=boris.ostrovsky@kernel.org>
Subject: Re: [PATCH v9 4/5] x86/PCI: Enable a 64bit BAR on AMD Family 15h
 (Models 30h-3fh) Processors v5
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        helgaas@kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, xen-devel <xen-devel@lists.xen.org>
References: <20171018135821.3248-1-deathsimple@vodafone.de>
 <20171018135821.3248-5-deathsimple@vodafone.de>
 <c5ca14bc-3812-ff15-7dd0-e862ce85a348@oracle.com>
 <d81d50e6-c267-fe43-214f-278e57903448@gmail.com>
 <26df0a78-8028-e42c-ce50-4cefe612a7e1@oracle.com>
 <3443aad0-8c3b-b97e-685a-96b0866827be@amd.com>
 <b937778c-556e-5587-c557-abba8cefe100@oracle.com>
 <bee2c953-0ab6-a086-9150-ae51e099655c@amd.com>
 <c2d52d00-8c3c-9944-29b3-3cab2f7c35f7@oracle.com>
 <7936fdd3-1615-ac1f-7b75-330ccb6a1a3f@amd.com>
 <0bb468d9-bc1d-e3c5-e313-1cf9408380f0@oracle.com>
 <275e859a-0ddd-ea7f-a681-67e42a5233fe@amd.com>
 <38bc76d9-2ed5-61f3-24b3-085031825181@oracle.com>
 <65885386-3dde-de23-7e95-7d96dfdf6033@oracle.com>
 <0ab28334-3ccc-2a93-9991-396ee01a3662@amd.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <cb0d5830-11dd-57b8-606b-7eca560cfcc7@oracle.com>
Date: Tue, 28 Nov 2017 13:55:58 -0500
MIME-Version: 1.0
In-Reply-To: <0ab28334-3ccc-2a93-9991-396ee01a3662@amd.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 11/28/2017 04:12 AM, Christian König wrote:
>
>
> How about the attached patch? It limits the newly added MMIO space to
> the upper 256GB of the address space. That should still be enough for
> most devices, but we avoid both issues with Xen dom0 as most likely
> problems with memory hotplug as well.

It certainly makes the problem to be less likely so I guess we could do
this for now.

Thanks.
-boris
