Return-Path: <SRS0=gj+u=DO=russell.cc=ruscur@kernel.org>
Return-Path: <SRS0=gj+u=DO=russell.cc=ruscur@kernel.org>
Message-ID: <1513570501.2133.2.camel@russell.cc>
Subject: Re: [PATCH v1 2/7] powerpc/kernel: Add uevents in EEH error/resume
From: Russell Currey <ruscur@russell.cc>
To: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, benh@kernel.crashing.org,
	paulus@samba.org, mpe@ellerman.id.au
Cc: seroyer@linux.vnet.ibm.com, jjalvare@linux.vnet.ibm.com,
 alex.williamson@redhat.com, helgaas@kernel.org, aik@ozlabs.ru,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bodong@mellanox.com,  eli@mellanox.com, saeedm@mellanox.com
Date: Mon, 18 Dec 2017 15:15:01 +1100
In-Reply-To: <20171213153242.98015-3-bryantly@linux.vnet.ibm.com>
References: <20171213153242.98015-1-bryantly@linux.vnet.ibm.com>
	 <20171213153242.98015-3-bryantly@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2017-12-13 at 09:32 -0600, Bryant G. Ly wrote:
> Devices can go offline when EEH is reported. This patch adds
> a change to the kernel object and lets udev know of error.
> When device resumes a change is also set reporting device as
> online. Therefore, EEH events are better propagated to user
> space for devices in powerpc arch.
> 
> Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
> Signed-off-by: Juan J. Alvarez <jjalvare@linux.vnet.ibm.com>
> 

It would probably also be useful to communicate when recovery fails and
a device is no longer usable, so userspace knows not to keep waiting
for recovery to complete.
