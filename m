Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35217 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751336Ab2K2P4M (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 29 Nov 2012 10:56:12 -0500
Message-ID: <1354204570.14547.14.camel@ul30vt.home>
Subject: Re: pci_enable_msix() fails with ENOMEM/EINVAL
From: Alex Williamson <alex.williamson@redhat.com>
To: Alex Lyakas <alex@zadarastorage.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org,
	Yair Hershko <yair@zadarastorage.com>,
	Shyam Kaushik <shyam@zadarastorage.com>
Date: Thu, 29 Nov 2012 08:56:10 -0700
In-Reply-To: <A5D6C5E3D7774E62AA482C886483DA6D@alyakaslap>
References: <190FFE9600054603A543CCDA4408AC89@alyakaslap>
	 <CAOcd+r28ot-060WQhUPkuM1Bt7t-_jOggAZKNSJxurNYVs2b-w@mail.gmail.com>
	 <1353536723.1809.4.camel@bling.home>
	 <F764A8A9BBE247FEA862ED33F77A04A1@alyakaslap>
	 <1353960253.1809.128.camel@bling.home>
	 <A5D6C5E3D7774E62AA482C886483DA6D@alyakaslap>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2012-11-29 at 10:42 +0200, Alex Lyakas wrote:
> Hi Alex,
> did I understand correctly that "vector" value with which the call to 
> request_threaded_irq() is made is *not* supposed to be zero? Because in my 
> case, it is always zero, and still the failure I observe is not happening 
> always. Usually, 3 unique (non-zero) IRQ numbers are assigned to each 
> attached PCI device of each KVM VM.
> I will try to repro this like you suggested and let you know.

pci_enable_msix should be setting vectors for all the host_msix_entries.
That non-zero vector is the first parameter to request_threaded_irq.  If
I put a printk in the loop installing the interrupt handler, I get:

assigned_device_enable_host_msix entry 0, vector 44
assigned_device_enable_host_msix entry 0, vector 44
assigned_device_enable_host_msix entry 1, vector 45
assigned_device_enable_host_msix entry 0, vector 44
assigned_device_enable_host_msix entry 1, vector 45
assigned_device_enable_host_msix entry 2, vector 103

So we enable MSI-X with only one vector enabled, then a second vector
gets enabled and we disable and re-enable with two, and so on with
three.  This is for an assigned e1000e device.  Thanks,

Alex

