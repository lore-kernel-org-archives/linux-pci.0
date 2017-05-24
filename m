Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46622 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967047AbdEXO5Q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 May 2017 10:57:16 -0400
Date: Wed, 24 May 2017 08:57:12 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Cheng, Collins" <Collins.Cheng@amd.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Zytaruk, Kelly" <Kelly.Zytaruk@amd.com>,
        Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] PCI: Make SR-IOV capable GPU working on the SR-IOV
 incapable platform
Message-ID: <20170524085712.4947e575@w520.home>
In-Reply-To: <BN6PR12MB124978AC5216B07455A0CD06ECFE0@BN6PR12MB1249.namprd12.prod.outlook.com>
References: <BN6PR12MB1249312205E07A670C54D2CFECE20@BN6PR12MB1249.namprd12.prod.outlook.com>
        <20170511212051.3b802325@t450s.home>
        <BN6PR12MB12492048A370FDEB7C14C8E8ECE20@BN6PR12MB1249.namprd12.prod.outlook.com>
        <20170511220113.2dfb6d3d@t450s.home>
        <BN6PR12MB12496DDEE84348A22AEA8AACECE20@BN6PR12MB1249.namprd12.prod.outlook.com>
        <20170512084304.3cf10653@t450s.home>
        <BN6PR12MB1249DA8407F452C407A7E2F2ECE10@BN6PR12MB1249.namprd12.prod.outlook.com>
        <20170515115332.0077753c@w520.home>
        <CAKgT0Ud1ODumcWsKeA8cyPfsOiHwvfF9tWKiM6QxubPpVjuUpQ@mail.gmail.com>
        <20170522094409.7e2968c2@w520.home>
        <BN6PR12MB1249C0626CE2AF98B2CDBCD8ECF90@BN6PR12MB1249.namprd12.prod.outlook.com>
        <20170523122013.6e2e4e59@w520.home>
        <BN6PR12MB124978AC5216B07455A0CD06ECFE0@BN6PR12MB1249.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 24 May 2017 08:57:53 +0000
"Cheng, Collins" <Collins.Cheng@amd.com> wrote:

> Hi Alex,
> 
> How do you know "particular this system offers no 64-bit MMIO", from dmesg log?

>From this:

> [    0.891319] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> [    0.891321] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> [    0.891322] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> [    0.891323] pci_bus 0000:00: root bus resource [mem 0x88800000-0xdfffffff window]
> [    0.891324] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
> [    0.891325] pci_bus 0000:00: root bus resource [bus 00-fe]

There are only 32-bit ranges listed.  Thanks,

Alex
