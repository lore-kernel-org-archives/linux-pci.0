Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35243 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419AbbJOUA5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 15 Oct 2015 16:00:57 -0400
Subject: Re: [PATCH v2] PCI: IOV: read SRIOV_NUM_VF after enabling ARI
To: Bjorn Helgaas <helgaas@kernel.org>,
	Ben Shelton <benjamin.h.shelton@intel.com>
References: <1444317617-13399-1-git-send-email-benjamin.h.shelton@intel.com>
 <20151015175825.GD17702@localhost>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Alexander Duyck <alexander.duyck@gmail.com>
Message-ID: <562005F7.7030205@gmail.com>
Date: Thu, 15 Oct 2015 13:00:55 -0700
MIME-Version: 1.0
In-Reply-To: <20151015175825.GD17702@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/15/2015 10:58 AM, Bjorn Helgaas wrote:
> Hi Ben,
>
> On Thu, Oct 08, 2015 at 10:20:17AM -0500, Ben Shelton wrote:
>> For some SR-IOV devices, the number of available virtual functions increases
>> after enabling ARI.  Currently, SRIOV_NUM_VF is read and saved off before the
>> ARI control bit is enabled in SRIOV_CTRL.  This causes an issue when VFs are
>> enabled.
>>
>> At device init, SRIOV_INITIAL_VF and SRIOV_NUM_VF are specified to contain the
>> number of available VFs for the device.  sriov_enable() does a sanity check
>> that SRIOV_INITIAL_VF is not greater than iov->total_VFs, the saved-off value
>> of SRIOV_NUM_VF.  Since the value of both SRIOV_INITIAL_VF and SRIOV_NUM_VF has
>> increased after enabling the ARI bit, the check fails, and the VFs cannot be
>> enabled.
>>
>> To fix the issue, write SRIOV_CTRL first, and then read SRIOV_NUM_VF.
>
> I think you mean PCI_SRIOV_TOTAL_VR (not NUM_VF), right?
>
> This is interesting because the spec says TotalVFs is HwInit, which
> means it's read-only, and it doesn't mention anything about it
> changing when ARIis enabled.  I can see why it would change in that
> case, so maybe this is just a goof in the spec.
>
> Bjorn

I think it is supposed to be HwInit because changing the value can cause 
issues with resource allocation for the VFs.  Specifically if the number 
of VFs increases after the BIOS has come through and assigned MMIO 
resources it is possible that there may not be resources available.

I suspect we are going to end up having to quirk a number of devices in 
the future because of this as I can see this easily causing issues.

- Alex

