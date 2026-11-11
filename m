Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=150.107.74.76
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794394142;
	b=SbyYkNq1VphX3ovDNk+GDxszihGu/+D2SQEHPdyf/0pVT29QbdrHU2/DQ8fkSfigdevL
	 QqqqaZm3Ml2KgDmxOxP60aJrS1faBhegzSkI+XeLHcDqBrCmPxC9k0RzeHeBGkT4oT49N
	 Vo/SjUFX89KM4RF94quN05gLHtNvUDEaz7qqrtiGGEFrm3C5p9E+77meUwNb0BcP6iWrT
	 E7CDEYsnPikG7+mACclk+SPpUHXHRBtSpmbb37QyqX8WoPtX0c4xC99I8vNLC76HwxQR2
	 q2FsCTYhkzmeyMRWTUrtt2dL/51sg8Uy2MdKKGLhUCWbHuKzipRXXa4BU5U7VUQ85Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794394142;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=UcIU49IoMwkMcPqVgct5VcN4m8udnqO+yv6+Crgi7s8=;
	b=wwMNrYwUyT1KqQUN1FeAB+wuLFcg4rG5cc1tstljq0MFmmAYBQgUZXWH+ehPGYPgGS9z
	 WVt//TV+aivXxAa3NrubBcKumR5OfkGFBbl6wUOuBEFvRcJDdqyg8C06M6I/BWaFsnmMv
	 JTJZ5zTtMlDyc/0m4GxUGL0wFA/Da81LUfiuGVdzRLGAjnqB1Flfa/FrDVglZB1EpXYuY
	 QjCBiMUNRSQbPpTkTPTAsODIKnXjs7YYg/O3iYQmN/JSGdkFiERr8VjliY8Rsd8TRRxha
	 oeqUQFFS5GYtfj88Xe0En20B4X9sZRTV9UN3FEwj0jm2uNABBTZ3Uenatm35GPSQwDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ozlabs.org;
	spf=pass smtp.mailfrom=ozlabs.org;
	dkim=pass header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256 header.s=201707 header.b=Wzpapjrr;
	arc=none smtp.remote-ip=150.107.74.76
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31228606A32A;
	Wed, 11 Nov 2026 10:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31228606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256 header.s=201707 header.b=Wzpapjrr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1794394138;
	bh=UcIU49IoMwkMcPqVgct5VcN4m8udnqO+yv6+Crgi7s8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=Wzpapjrrl5t3gWo9iDKn1jyk+NtYI3fWGuLAdCwwM44sKU9JbK4sXihTqucOVCMmC
	 mQbeyBBAQffCtcG4/uX5Ernoz8F+8c1wcp4YZ8eK+Q83xlTCOYMnoj1LZpKci57MEc
	 CaB2iUEZ7k/HBnRqh02BnwjwOlfFW0TRXj1b0u77E9vFWILuk+dZO7luBhYApBhchK
	 N/UxzXMRqHfNaDWsmwfENCVcXqKrpCheglaAAxj9b1YJUyvPKncLXGmzMysGu9+49A
	 NzwUNL9cSRrgLBNhlfGxiIUfojcjZ8MTe7XArRgtHAP7/ZiL4WRsbdCqpgMf/aVlBn
	 73ZNIXg1s6sAg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4jPgHR2Zsdz4wKs;
	Wed, 11 Nov 2026 21:48:50 +1100 (AEDT)
Message-ID: <df301c78-2745-4c64-a331-c830efb74660@ozlabs.org>
Date: Wed, 11 Nov 2026 10:48:47 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 8/9] vfio/pci: Support mmap() of a VFIO DMABUF
From: Matt Evans <matt@ozlabs.org>
To: Alex Williamson <alex@shazbot.org>
Cc: Alex Mastro <amastro@fb.com>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Kevin Tian <kevin.tian@intel.com>,
 Pranjal Shrivastava <praan@google.com>, Longfang Liu
 <liulongfang@huawei.com>, Mahmoud Adam <mngyadam@amazon.de>,
 David Matlack <dmatlack@google.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Ankit Agrawal <ankita@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20261006193643.76330-1-matt@ozlabs.org>
 <20261006193643.76330-9-matt@ozlabs.org>
 <20261013171347.54e856c7@shazbot.org>
 <0bd00c26-4f53-4387-86be-99f0c37fa47c@ozlabs.org>
Content-Language: en-GB
In-Reply-To: <0bd00c26-4f53-4387-86be-99f0c37fa47c@ozlabs.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alex,

On 14/10/2026 21:38, Matt Evans wrote:
> Hi Alexes,
> 
> On 14/10/2026 00:13, Alex Williamson wrote:
>> On Tue,  6 Oct 2026 20:36:36 +0100
>> Matt Evans <matt@ozlabs.org> wrote:
>>
>>> A VFIO DMABUF can export a subset of a BAR to userspace by fd; add
>>> support for mmap() of this fd.  This provides another route for a
>>> process to map BARs, in which the process can only map a specific
>>> subset of a BAR represented by the exported DMABUF.
>>>
>>> mmap() support enables userspace drivers to safely delegate BAR
>>> sub-ranges to other processes by sharing a DMABUF fd, without having
>>> to share the (omnipotent) VFIO device fd with them.
>>>
>>> Since the main VFIO BAR mmap() is now DMABUF-aware, the new mmap() 
>>> reuses
>>> the existing vm_ops.
>>>
>>> The lifecycle of an exported DMABUF remains decoupled from that of the
>>> device fd it came from, i.e. the device fd could be closed with DMABUF
>>> VMAs present, meaning a fault on a VMA could happen concurrently with
>>> vfio_pci_dma_buf_cleanup().
>>>
>>> To deal with this scenario, the fault handler now temporarily takes a
>>> VFIO device registration to ensure the vdev remains valid, and then
>>> vdev locks can be taken.
>>
>> This sounds like potentially measurable overhead if something is
>> slamming the fault handler where huge-fault is not supported or active.
>> Have you considered a fast path for the internal dmabuf where the
>> lifecycle is constrained?
> [snip]
> 
> Hmm.  I'll hack up a test to try to measure the relative overhead of VMA 
> faults before/after (modulo access to meaningful HW).

Alex Mastro and I have put together some tests, and measured this 
overhead on the v8 series.

https://github.com/evansm7/vfio-playground/tree/master/vfio-barmap-perf

Alex also generated a similar test with a slightly different method:
  https://github.com/opsound/vfio-tools/blob/main/vfio_bar_bench.c


Test method:

Time accesses to a VFIO mmap'd BAR immediately after the mmap, to 
measure the 'cold' initial fault time.  Re-time a second pass for which 
the pagetable should now be populated, and subtract.  This should 
isolate the cost of the fault (uarch exception, generic pagefault 
plumbing, VFIO fault handler) from common costs (the MMIO access itself, 
TLB misses, the loop iterating across the BAR).  Maximise the number of 
faults by disabling hugepages (per concern above).

This is done both for a single-threaded case which just iterates across 
a new BAR mapping, and a multi-threaded contended case.  Rather than 
just pthreads, this test fork()s to try to avoid seeing contention on 
per-mm locks (e.g. mmap_lock) and to focus on the VMA/VFIO locking.

The default test mmaps before forking, meaning there's one shared 
mapping/DMABUF accessed from both processes.  The fault handler should 
then contend on dmabuf->resv, vdev->memory_lock, and vdev->dmabuf_lock.

For comparison/curiosity, the --mt-map-late option mmaps _after_ 
forking; this leads to a mapping/DMABUF in each process so I expect no 
contention on dmabuf->resv (but still on memory_lock/dmabuf_lock).

Alex's test instead runs threads in-process, and goes further with 
supporting a larger number of threads (though with the caveat that they 
may also be fighting over intra-process mm locks).  It also supports a 
mode where threads can access per-thread VMAs (which is comparable to 
the 'mt-map-late' option of my test).  Both are interesting approaches IMO.


Findings:

On the dusty AMD Ryzen 3950X under my desk (targeting a 256MB BAR) I 
found the following averaged over 200 runs:

  - A single-threaded/uncontended fault became 5.8% slower
  - A two-process contended case became 8.7% slower
   - 0.5% of this is the "early mmap" dmabuf->resv contention, i.e. using
     mt-map-late (a mapping in each process) reduces by 0.5%.

Alex's runs on fancier EPYC 9334 machines show a similar (slightly 
lower) overhead in the 1-2 case, and go on to show fairly high overhead 
when many threads are involved (baseline times in ns, relative series v8 
behaviour in percentage change):

   Threads    One shared mapping   Mapping per thread
              7.3     v8            7.3     v8
   --------------------------------------------
      1       761   +4.5%           777   +2.7%
      2       869   +6.6%           840   +5.6%
      8      1465    +78%          1363    +47%
     16      4152    +97%          4258    +19%
     32      9927    +92%         10158    +12%


Now.  The absolute timings of these sub-microsecond faults indicate a 
realistic application won't see a human-visible change.  Small BARs 
mapped with 4k pages are still fast to map;  it is reasonable to ask 
that applications map huge (GBs/TBs) BARs using huge (MB/GB) pages!  Of 
course, this is just a one-time cost of warming up the VMA, not ongoing.


Alex, my preference is not to complicate the fault handler with a fast 
path just yet.  It's easy to think of a contrived scenario where this 
matters but in middle-of-the-road application behaviour it would be 
surprising if this was noticeable.  What are your thoughts?

(In the previous mail I suggested keying off priv->vfile (or a flag 
thereof), and it seems ~straightforward to skip the extra 
synchronisation.  If you feel strongly that the fault handler doesn't 
have enough if() statements yet and needs more paths then we could bring 
this into v9, but would prefer to follow up later. :)  A fastpath diff 
appears small but the reasoning overhead is bigger.)


Thanks,


Matt

