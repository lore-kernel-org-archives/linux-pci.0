Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725724AbeIOEg6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 15 Sep 2018 00:36:58 -0400
Subject: Re: [PATCH v2 2/6] PCI: Expose reset_type to users of
 pci_reset_function()
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-pci@vger.kernel.org
Cc: alex.williamson@redhat.com, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Frank Haverkamp <haver@linux.vnet.ibm.com>,
        "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Harish Patil <harish.patil@cavium.com>,
        Manish Chopra <manish.chopra@cavium.com>,
        Dept-GELinuxNICDev@cavium.com,
        "David S. Miller" <davem@davemloft.net>,
        Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        Edward Cree <ecree@solarflare.com>,
        Bert Kenward <bkenward@solarflare.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Anton Vasilyev <vasilyev@ispras.ru>
References: <20180914211808.2564-1-okaya@kernel.org>
 <20180914211808.2564-3-okaya@kernel.org>
 <be6c6d59e1a199eea4b9a1b406d78a8ce0dc67e5.camel@linux.intel.com>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <32331f85-0971-647e-17aa-8549cd1751d6@kernel.org>
Date: Fri, 14 Sep 2018 19:20:06 -0400
MIME-Version: 1.0
In-Reply-To: <be6c6d59e1a199eea4b9a1b406d78a8ce0dc67e5.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 9/14/2018 5:52 PM, Srinivas Pandruvada wrote:
>> Signed-off-by: Sinan Kaya<okaya@kernel.org>
>> ---
>>   drivers/hid/intel-ish-hid/ipc/ipc.c             | 2 +-
> For intel-ish-hid, change looks fine.

Is this an ACK or reviewed-by?
