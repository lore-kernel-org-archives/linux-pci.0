Return-Path: <SRS0=jDWQ=FQ=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=jDWQ=FQ=codeaurora.org=okaya@kernel.org>
Subject: Re: FLR on AER
To: Jon Masters <jcm@redhat.com>, helgaas@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <75DE2522-5DDC-4852-BE38-F7EB53691196@redhat.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <372f63b2-2739-51fe-8959-3c5a0fecc29e@codeaurora.org>
Date: Thu, 22 Feb 2018 08:57:21 -0500
MIME-Version: 1.0
In-Reply-To: <75DE2522-5DDC-4852-BE38-F7EB53691196@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 2/22/2018 8:21 AM, Jon Masters wrote:
> Hi Bjorn,
> 
> It looks like the AER driver won’t do a device FLR but instead will default to progressively bigger hammers. Am I missing something?
> 

AFAIK, AER driver does a secondary bus reset only if it observes a FATAL error. In order to
issue an FLR, driver needs to access the endpoint config space. Since there is a FATAL error,
this is not possible as PCI link is unreliable or probably gone.

> Jon.
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
