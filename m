Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48548 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726404AbeGMFPF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Jul 2018 01:15:05 -0400
Date: Fri, 13 Jul 2018 13:02:04 +0800
From: Peter Xu <peterx@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@gibson.dropbear.id.au
Subject: Re: [PATCH] vfio-pci: Disable binding to PFs with SR-IOV enabled
Message-ID: <20180713050204.GB2379@xz-mi>
References: <20180712223243.9593.24855.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180712223243.9593.24855.stgit@gimli.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 12, 2018 at 04:33:04PM -0600, Alex Williamson wrote:
> We expect to receive PFs with SR-IOV disabled, however some host
> drivers leave SR-IOV enabled at unbind.  This puts us in a state where
> we can potentially assign both the PF and the VF, leading to both
> functionality as well as security concerns due to lack of managing the
> SR-IOV state as well as vendor dependent isolation from the PF to VF.
> If we were to attempt to actively disable SR-IOV on driver probe, we
> risk VF bound drivers blocking, potentially risking live lock
> scenarios.  Therefore simply refuse to bind to PFs with SR-IOV enabled
> with a warning message indicating the issue.  Users can resolve this
> by re-binding to the host driver and disabling SR-IOV before
> attempting to use the device with vfio-pci.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
