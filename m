Return-Path: <SRS0=xqcU=4Y=networkplumber.org=stephen@kernel.org>
Return-Path: <SRS0=xqcU=4Y=networkplumber.org=stephen@kernel.org>
Date: Thu, 18 May 2017 16:58:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jork Loeser <jloeser@linuxonhyperv.com>
Cc: Jork Loeser <jloeser@microsoft.com>, helgaas@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
 vkuznets@redhat.com, jasowang@redhat.com, leann.ogasawara@canonical.com,
 marcelo.cerri@canonical.com, sthemmin@microsoft.com, Vitaly Kuznetsov
 <vkuznets@redhat.com>
Subject: Re: [PATCH 4/4] Hyper-V vPCI: use vPCI protocol version 1.2
Message-ID: <20170518165854.46fd92fa@xeon-e3>
In-Reply-To: <1495134870-18225-5-git-send-email-jloeser@linuxonhyperv.com>
References: <1495134870-18225-1-git-send-email-jloeser@linuxonhyperv.com>
	<1495134870-18225-5-git-send-email-jloeser@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Thu, 18 May 2017 12:14:30 -0700
Jork Loeser <jloeser@linuxonhyperv.com> wrote:

> From: Jork Loeser <jloeser@microsoft.com>
> 
> Update the Hyper-V vPCI driver to use the Server-2016 version
> of the vPCI protocol, fixing MSI creation and retargeting issues.
> 
> Signed-off-by: Jork Loeser <jloeser@microsoft.com>

This patch conflicts with already submitted patch that removes
vmbus_cpu_number_to_vp_number()

commit 4b28e5c28cc32652d200a31795e38ee6c819a4a2
Author: Vitaly Kuznetsov <vkuznets@redhat.com>
Date:   Mon May 15 13:38:26 2017 -0700

    hyper-v: globalize vp_index
    
    To support implementing remote TLB flushing on Hyper-V with a hypercall
    we need to make vp_index available outside of vmbus module. Rename and
    globalize.
    
    Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
