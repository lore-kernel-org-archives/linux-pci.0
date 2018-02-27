Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:22314 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751754AbeB0WpV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Feb 2018 17:45:21 -0500
From: "Rustad, Mark D" <mark.d.rustad@intel.com>
To: David Miller <davem@davemloft.net>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Daly, Dan" <dan.daly@intel.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "MRustad@gmail.com" <MRustad@gmail.com>,
        "alexander.duyck@gmail.com" <alexander.duyck@gmail.com>,
        "mst@redhat.com" <mst@redhat.com>
Subject: Re: [RFC PATCH V3] virtio_pci: Add SR-IOV support
Date: Tue, 27 Feb 2018 22:45:19 +0000
Message-ID: <CABB6175-4FC3-4742-9C54-FCDEE3E5A608@intel.com>
References: <20180226031911.18980.80488.stgit@mdrustad-mac04.local>
 <20180227.103502.2160088807348773566.davem@davemloft.net>
In-Reply-To: <20180227.103502.2160088807348773566.davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> On Feb 27, 2018, at 7:35 AM, David Miller <davem@davemloft.net> wrote:
> 
> I don't like these helpers on many different levels.

<snip much embarrassment>

> So kill off pci_sriov_enable() helper completely, it is unnecessary,
> and rename the disable helper so that it says something meaningful to
> the reader.

Yes. Once pointed out, I completely agree with your comments and wish that I had seen those things myself.

> Thanks.

V3 was junk, but your comments apply to V4 as well, so please ignore it.

Thank you for your valuable review.

-- 
Mark Rustad, Networking Division, Intel Corporation
