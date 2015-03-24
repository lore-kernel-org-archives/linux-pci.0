Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Aaron Lu <aaron.lu@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI: rename dsm uuid for PCI
Date: Tue, 24 Mar 2015 02:03:52 +0100
Message-ID: <13489176.3njQWsGiXL@vostro.rjw.lan>
In-Reply-To: <5510B158.6060006@intel.com>
References: <54FD4FB9.2060802@intel.com> <1641780.MlgGlmpUFR@vostro.rjw.lan> <5510B158.6060006@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, March 24, 2015 08:35:36 AM Aaron Lu wrote:
> On 03/24/2015 08:24 AM, Rafael J. Wysocki wrote:
> > So _DSM is an ACPI-defined object and please spell its name like that.
> > Also please spell UUID in capitals if that's not a problem.
> 
> Something like acpi_pci_dsm_UUID?

No, not in variable names. :-)

In the subject, comments etc (where it makes sense).


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
