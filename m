Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ua0-f175.google.com ([209.85.217.175]:35554 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755263AbdDQVpc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Apr 2017 17:45:32 -0400
Received: by mail-ua0-f175.google.com with SMTP id f10so60010784uaa.2
        for <linux-pci@vger.kernel.org>; Mon, 17 Apr 2017 14:45:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170417213639.21092.22951.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170417212705.21092.90222.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20170417213639.21092.22951.stgit@bhelgaas-glaptop.roam.corp.google.com>
From: Yinghai Lu <yinghai@kernel.org>
Date: Mon, 17 Apr 2017 14:45:31 -0700
Message-ID: <CAE9FiQW0ds9fXmu77eJscBhYQnQKa9J=+KWThEwC3Kc++YCE-Q@mail.gmail.com>
Subject: Re: [PATCH v11 2/7] PCI: A fix for caculating bridge window's size
 and alignment
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yongji Xie <elohimes@gmail.com>,
        Li Zhong <zhong@linux.vnet.ibm.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Gavin Shan <gwshan@linux.vnet.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 17, 2017 at 2:36 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> From: Yongji Xie <elohimes@gmail.com>
>
> In case that one device's alignment is greater than its size,
> we may get an incorrect size and alignment for its bus's memory
> window in pbus_size_mem(). This patch fixes this case.

In which case, that device alignment is not same as size?
or powerpc need small size, but alignment is PAGE_SIZE?

Thanks

Yinghai
